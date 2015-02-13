CircleCIStats.configure do |config|
  config.token = ENV["CIRCLECITOKEN"]
  config.repository = ENV["CIRCLECIREPO"]
  config.username = ENV["CIRCLECIUSERNAME"]
end
