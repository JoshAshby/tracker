module Mental
  module_function
  def pushbullet
    @@pushbullet ||= Washbullet::Client.new Mental.config_for(:pushbullet)[:key]
  end
end
