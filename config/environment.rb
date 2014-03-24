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



eb_auth_tokens = {
									 app_key: 'XDZVAB6BIBH52S27PU',
									 user_key: '139301281190391193493'
									}

eb_client = EventbriteClient.new(eb_auth_tokens)



# APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# env_config = YAML.load_file(APP_ROOT.join('config', 'eventbrite.yml'))

# env_config.each do |key, value|
#   ENV[key] = value
# end

# #Eventbrite API authorization
# Eventbrite.configure do |config|
# 	config.eb_client_app_key = ENV["app_key"]
# 	config.eb_client_user_key = ENV["user_key"]
# end

#Eventbrite example API method calls
		#Here is an example using the API's user_list_events method:

		#response = eb_client.user_list_events()
		#The event_get API call should look like this:
		#response = eb_client.event_get({ id: 1848891083})

		# response = eb_client.user_list_events()
		#The event_get API call should look like this:
		# response = eb_client.event_get({ id: 1848891083})


