require './tracker'
# require 'sidekiq/web'

run Rack::URLMap.new('/' => ApplicationController) # , '/sidekiq' => Sidekiq::Web)

trap("INT"){ exit }
