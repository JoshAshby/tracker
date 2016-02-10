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
end
