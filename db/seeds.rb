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

template = QuestionaireTemplate.create name: "How ya doin?"

question_response = [
  {
    prompt: 'Happy',
    type: :single_choice,
    meta: {
      choices: [
        {
          name: ':)',
          value: '1'
        },
        {
          name: ':|',
          value: '0'
        },
        {
          name: ':(',
          value: '-1'
        }
      ]
    },
    response: '0'
  },
  {
    prompt: 'Question?',
    type: :text,
    response: 'meh'
  }
]

questions = question_response.map do |q|
  question = Question.create prompt: q[:prompt], type: q[:type], meta: q[:meta]
  template.add_question question

  question
end

template.save

questionaire = Questionaire.create user: users['ashby'], questionaire_template: template, completed: true

questions.each.with_index do |question, i|
  Response.create user: users['ashby'], questionaire: questionaire, question: question, response: question_response[i][:response]
end
