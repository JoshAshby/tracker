module Tracker
  module_function
  def pushbullet
    @@pushbullet ||= Washbullet::Client.new Tracker.config_for(:pushbullet)[:key]
  end
end
