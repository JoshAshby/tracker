object @questionnaire

attributes :id, :user_id

node :questions_order do |questionnaire|
  questionnaire.questionnaire_template.questions.map(&:id)
end

node :questions do |questionnaire|
  questionnaire.questionnaire_template.questions.inject({}) do |memo, question|
    memo[question.id] = {
      prompt:  question.prompt,
      type:    question.type,
      choices: question.choices
    }

    memo
  end
end

node :responses do |questionnaire|
  questionnaire.responses.inject({}) do |memo, response|
    memo[response.question_id] = {
      id:         response.id,
      responses:  response.responses
    }

    memo
  end
end
