require './mental'
# require 'sidekiq/web'

run Rack::URLMap.new('/' => ApplicationController) # , '/sidekiq' => Sidekiq::Web)

trap("INT"){ exit }
