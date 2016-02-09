class ApplicationController < BaseController
  use HealthController
  use AuthenticationController
  use QuestionaireController

  get '/' do
    return haml :login unless logged_in?

    redirect to('/questionaires')
  end
end
