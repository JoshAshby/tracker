object @questionnaire

attributes :id, :user_id

node :questions do |questionnaire|
  questionnaire.responses_dataset.eager(:question).all.map do |response|
    question = response.question

    {
      question: {
        id: question.id,
        prompt:    question.prompt,
        choices:   question.choices,
        emojify:   question.emojify
      },
      response: {
        id: response.id,
        responses: response.responses
      }
    }
  end
end
