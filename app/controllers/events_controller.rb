
class EventsController < ApplicationController
  respond_to :json

	#API Request
	#initialize our http object, for contacting the API
	http = Net::HTTP.new('www.eventbrite.com', 443)
	http.use_ssl=true

	#make our API request - 
	response = eb_client.event_search({ "Last Week" })

	#parse our JSON response data...
	events_list = JSON.parse(response.body)

	def popular_events
		@popular_events = events_list
	end

 
end
