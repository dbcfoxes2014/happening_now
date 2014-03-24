
class EventsController < ApplicationController
  respond_to :json

	def popular_events
		@popular_events = events_list
	end

	#API Request

	#initialize our http object, for contacting the API
	http = Net::HTTP.new('www.eventbrite.com', 443)
	http.use_ssl=true

	#make API request


	#make our API request - 
	response = http.request_get( URI.escape('https://www.eventbrite.com/json/event_search?keywords=popular'))

	#parse our JSON response data...
	events_list = JSON.parse(response.body)
 
end
