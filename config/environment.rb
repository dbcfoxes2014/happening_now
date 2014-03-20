# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
FreeCandy::Application.initialize!

Instagram.configure do |config|
  config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
  config.client_secret = ENV["INSTAGRAM_SECRET"]
end