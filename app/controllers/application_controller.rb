class ApplicationController < BaseController
  use HealthController
  use AuthenticationController
  use QuestionnaireController

  get '/' do
    return haml :login unless logged_in?

    redirect to('/questionnaires')
  end
end
