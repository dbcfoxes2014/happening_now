class EventController < ApplicationController
  respond_to :json

	def popular_events
	response = $eb_client.event_search("Last Week")		
	@e = JSON.parse(response.body)
	@e["events"].delete_at(0)

	render :events
	end 
end