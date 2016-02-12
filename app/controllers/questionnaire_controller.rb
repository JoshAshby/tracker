class QuestionnaireController < BaseController
  get '/questionnaires' do
    authenticate!

    @title = 'All'
    @questionnaires = current_user.questionnaires_dataset.eager(:questionnaire_template).order{ created_at }

    haml :questionnaires
  end

  get '/questionnaires/complete' do
    authenticate!

    @title = 'Complete'
    @questionnaires = current_user.questionnaires_dataset.where{ completed =~ true }.eager(:questionnaire_template).order{ created_at }

    haml :questionnaires
  end

  get '/questionnaires/incomplete' do
    authenticate!

    @title = 'Incomplete'
    @questionnaires = current_user.questionnaires_dataset.where{ completed =~ false }.eager(:questionnaire_template).order{ created_at }

    haml :questionnaires
  end

  get %r|/questionnaire/(?<id>\w*)/?| do
    authenticate!

    @questionnaire = Questionnaire.find id: params['id']

    if @questionnaire.completed
      haml :complete_questionnaire
    else
      @questionnaire_data = rabl :questionnaire
      haml :incomplete_questionnaire
    end
  end

  # set(:auth) do |yesno|
  #   condition do
  #     next unless yesno

  #     redirect to('/login'), 303 unless logged_in?
  #   end
  # end

  # set(:permit) do |**groups|
  #   condition do
  #     unless logged_in? && groups.any?{ |namespace, action| current_user.can? resource: Feature.by_name(namespace), action: action }
  #       redirect to('/')
  #     end
  #   end
  # end

  def json
    request.body.rewind
    @json ||= JSON.parse request.body.read
  end

  post %r|/questionnaire/(?<id>\w*)/?| do
    authenticate!

    @questionnaire = Questionnaire.find id: params['id']

    ap @questionnaire

    if @questionnaire.completed
      halt JSON.dump({
        errors: [
          {
            id: SecureRandom.hax,
            code: 0,
            title: 'Questionnaire Already Complete',
            detail: "This questionnaire is already complete, can't respond",
            meta: {}
          }
        ]
      }), 422
    end

    json['questionnaire']['responses'].each do |question_id, responses|
      question_id = question_id.to_i
      Response.find_or_new user: current_user, questionnaire: @questionnaire, question_id: question_id do |response|
        response.responses = responses
      end.save
    end

    if @questionnaire.questionnaire_template.questions.count == @questionnaire.responses.count
      @questionnaire.completed = true
      @questionnaire.save
    end

    rabl :questionnaire
  end
end
