class QuestionaireController < BaseController
  get '/questionaires' do
    authenticate!

    @title = 'All'
    @questionaires = current_user.questionaires_dataset.eager(:questionaire_template).order{ created_at }

    haml :questionaires
  end

  get '/questionaires/complete' do
    authenticate!

    @title = 'Complete'
    @questionaires = current_user.questionaires_dataset.where{ completed =~ true }.eager(:questionaire_template).order{ created_at }

    haml :questionaires
  end

  get '/questionaires/incomplete' do
    authenticate!

    @title = 'Incomplete'
    @questionaires = current_user.questionaires_dataset.where{ completed =~ false }.eager(:questionaire_template).order{ created_at }

    haml :questionaires
  end

  get '/questionaire/:id' do
    authenticate!

    @questionaire = Questionaire.find id: params[:id]

    if @questionaire.complete
      haml :complete_questionaire
    else
      haml :incomplete_questionaire
    end
  end
end
