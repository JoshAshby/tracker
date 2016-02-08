require 'sinatra/base'
require 'sinatra/content_for'

require 'haml'
require 'tilt/haml'

require 'rabl'

require 'erb'
require 'tilt/erb'

Rabl.register!

class ApplicationController < Sinatra::Base
  set :views, -> { Mental.root.join 'app/views' }
  set :public_folder, -> { Mental.root.join('public') }

  # use Rack::Session::Cookie
  # use OmniAuth::Builder do
  # end

  # Setup logging for access and error logs, just for niceness.
  use Rack::CommonLogger, Mental.logger
  ::Logger.class_eval{ alias :write :'<<' }
  access_log        = Mental.root.join('logs','access.log')
  access_logger     = ::Logger.new(access_log)
  error_logger      = ::File.new(Mental.root.join('logs','error.log'), "a+")
  error_logger.sync = true

  helpers Sinatra::ContentFor

  configure do
    use ::Rack::CommonLogger, access_logger
  end

  before do
    env["rack.errors"] = error_logger
  end

  get '/' do
    haml :index
  end

  # omniauth template
  # get '/auth/:provider/callback' do
  # end

  # Health endpoint for dokku to hit to ensure that the app deployed well
  get '/ping' do
    'pong'
  end
end
