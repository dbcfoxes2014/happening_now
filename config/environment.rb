# Load the Rails application.
require File.expand_path('../application', __FILE__)
# require 'instagram.yaml'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

env_config = YAML.load_file(APP_ROOT.join('config', 'instagram.yml'))

env_config.each do |key, value|
  ENV[key] = value
end

Instagram.configure do |config|
  config.client_id = ENV["CLIENT_ID"]
  config.client_secret = ENV["CLIENT_SECRET"]
end

# Initialize the Rails application.
FreeCandy::Application.initialize!

