# Load the Rails application.
require File.expand_path('../application', __FILE__)



# Initialize the Rails application.
FreeCandy::Application.initialize!

$IG_CLIENT = Instagram.configure do |config|
  config.client_id = "cf46fbec21fe4f848d9ddb0ace6d0978"
  config.client_secret = "5ab67228feb3463fa6df817770260245"
end
