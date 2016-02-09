require 'sinatra/base'
require 'sinatra/content_for'
require 'sinatra/flash'

require 'haml'
require 'tilt/haml'

require 'rabl'

require 'erb'
require 'tilt/erb'

Rabl.register!

class BaseController < Sinatra::Base
  set :views, -> { Tracker.root.join 'app', 'views' }
  set :public_folder, -> { Tracker.root.join 'public' }

  enable :sessions

  # use Rack::Session::Cookie
  # use OmniAuth::Builder do
  # end

  # Setup logging for access and error logs, just for niceness.
  use Rack::CommonLogger, Tracker.logger
  ::Logger.class_eval{ alias :write :'<<' }
  access_log        = Tracker.root.join('logs','access.log')
  access_logger     = ::Logger.new(access_log)
  error_logger      = ::File.new(Tracker.root.join('logs','error.log'), "a+")
  error_logger.sync = true

  configure do
    use ::Rack::CommonLogger, access_logger
  end

  before do
    env["rack.errors"] = error_logger
  end

  helpers Sinatra::ContentFor
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.find id: session[:user_id]
    end

    def logged_in?
      current_user.present?
    end

    def bulma_flash key: :flash
      return "" if flash(key).empty?
      id = (key == :flash ? "flash" : "flash-#{key}")

      messages = flash(key).collect do |type, msg|
        className = case type
        when :error
          'is-danger'
        when :warning
          'is-warning'
        when :success
          'is-success'
        when :info
          'is-info'
        else
          ''
        end
        "<div class='notification #{ className } flash #{ type }'>#{ msg }</div>"
      end

      "<div class='container' id='#{ id }'>#{ messages.join }</div>"
    end

    def react_component name, data={}
     "<div class='react-component' data-react='#{ name }' data-payload='#{ data.to_json }'></div>"
    end
  end

  def authenticate!
    unless logged_in?
      session[:return_path] = request.path
      flash[:error] = "You need to login to access that"
      halt redirect(to('/'))
    end
  end
end
