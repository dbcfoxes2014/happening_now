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

#Eventbrite API authorization
eb_client = EventbriteClient.new(eb_auth_tokens)

#Eventbrite example API method calls
		#Here is an example using the API's user_list_events method:
		response = eb_client.user_list_events()
		#The event_get API call should look like this:
		response = eb_client.event_get({ id: 1848891083})

