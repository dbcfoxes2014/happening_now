class EventController < ApplicationController
	include SearchHelper
  respond_to :json


	def popular_events
	response = $eb_client.event_search("Last Week")		
	@e = JSON.parse(response.body)
	@e["events"].delete_at(0)

	render :events
	end 

	def find_location
		@event = $eb_client.event_get(id: params[:id])
		if @event['event']['venue']
			# @lat = @event['event']['venue']['latitude']
			# @long = @event['event']['venue']['longitude']
			@lat = 41.889435
			@long = -87.636094
			# @start = @event['event']['start_date']
			@media = find_media_by_location(@lat, @long)
		else
			values = seperate_values(@event['event']['title'], ' ')
			@media = grab_all_media(values)
		end

		render partial: 'media/display'
	end
end
