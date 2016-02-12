groups = {
  'admin' => {
    name: 'admin'
  }
}.inject({}) do |memo, (key, data)|
  memo[key] = Group.create(**data)
  memo
end

users = {
  'ashby' => {
    username: 'ashby',
    password: 'test',
    preferences: {
      email: 'joshashby@joshashby.com'
    },
    groups: [
      'admin'
    ]
  }
}.inject({}) do |memo, (key, data)|
  user = User.create(**data.slice(:username, :password))

  if data.has_key? :preferences
    data[:preferences].each do |k, v|
      next unless User.preferences.has_key? k.to_sym
      user.set_preference k, v unless user.get_preference k
    end
  end

  if data.has_key? :groups
    data[:groups].each do |g|
      next unless groups.has_key? g
      groups[g].add_user user
    end
  end

  memo[key] = user
  memo
end

groups.values.each(&:save)

template = QuestionnaireTemplate.create name: "Sample"

question_response = [
  {
    prompt: 'Happy',
    type: :single_choice,
    choices: [
      ':D',
      ':)',
      ':|',
      '):',
      'D:'
    ],
    responses: [':|']
  },
  {
    prompt: 'okay',
    type: :multiple_choice,
    choices: [
      1,
      2,
      3,
      5
    ],
    responses: [1,2,3]
  },
  {
    prompt: 'Question?',
    type: :text,
    responses: ['meh :) :( :| just meh']
  }
]

questions = question_response.map do |q|
  question = Question.create prompt: q[:prompt], type: q[:type], choices: q[:choices]
  template.add_question question

  question
end

template.save

finished_questionnaire = Questionnaire.create user: users['ashby'], questionnaire_template: template, completed: true

questions.each.with_index do |question, i|
  Response.create user: users['ashby'], questionnaire: finished_questionnaire, question: question, responses: question_response[i][:responses]
end

6.times do
  Questionnaire.create user: users['ashby'], questionnaire_template: template, completed: false
end
