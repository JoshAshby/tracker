class ApplicationController < BaseController
  use HealthController
  use AuthenticationController
  use QuestionnaireController

  get '/' do
    redirect to('/questionnaires')
  end
end
