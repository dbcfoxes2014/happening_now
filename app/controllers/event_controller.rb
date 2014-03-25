class EventController < ApplicationController
	include SearchHelper
  respond_to :json


	def popular_events
		response = $eb_client.event_search("Last Week")
		@e = JSON.parse(response.body)
		@e["events"].delete_at(0)

		render :popular

	end

	def find_location
		@event = $eb_client.event_get(id: params[:id])
		venue = @event['event']['venue']
		if venue['latitude'] > 0
			venue_chars = venue['name'].split('').sort.join('').strip
			lat = venue['latitude']
			long = venue['longitude']
			start = @event['event']['start_date']
			venue_id = find_id_by_location(lat, long, venue_chars)
			if venue_id.nil?
				@media = find_media_by_location(lat, long, start)
			else
				@media = find_media_by_venue(venue_id)
			end
		else
			values = seperate_values(@event['event']['title'], ' ')
			@media = grab_all_media(values)
		end

		render :events
	end
end




