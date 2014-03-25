
class EventController < ApplicationController
  respond_to :json

	eb_auth_tokens = {
									 app_key: 'XDZVAB6BIBH52S27PU',
									 user_key: '139301281190391193493'
									}
	eb_client = EventbriteClient.new(eb_auth_tokens)

	# API Request
	# initialize our http object, for contacting the API
	http = Net::HTTP.new('www.eventbrite.com', 443)
	http.use_ssl=true


	#make our API request - 
	
	#parse our JSON response data...

	def popular_events
		response = $eb_client.event_search("Last Week")		
		@e = JSON.parse(response.body)
		@e["events"].delete_at(0)
		# puts response
		# @popular_events = response
		# binding.pry
		render :events
	end

 
end
