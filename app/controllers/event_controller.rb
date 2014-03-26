#####################TEST IP ADDRESS###################
# class Rack::Request 
# 	def ip 
# 		'184.154.83.119' 
# 	end 
# end


class EventController < ApplicationController
	include EventHelper
	include SearchHelper
  respond_to :json



	def popular_events
		user_city = request.location.city
	
		response = $eb_client.event_search(city: user_city, date: "Past")		
		
		@e = JSON.parse(response.body)
		@e["events"].delete_at(0)
		render :popular
	end

	def find_venue_location(event)
		event = event['event']
		if event['venue']['latitude'] > 0
			venue_chars = event['venue']['name'].split('').sort.join('').strip
			lat = event['venue']['latitude']
			long = event['venue']['longitude']
			start = event['start_date']
			media = find_id_by_location(lat, long, venue_chars)
		else
			nil
		end
	end

	def find_event_media
		event = find_event(params[:id])
		if event['event']['venue']
			venue_id = find_venue_location(event)
			if venue_id.nil?
				@event_message = "No venue was found, here is some media from that area!"
				@media = find_media_by_location(event['event']['venue']['latitude'], event['event']['venue']['longitude'], event['event']['start_date'])
			else
				@event_message = "Media from #{event['event']['title']}"
				@media = find_media_by_venue(venue_id)
			end
		else
			@event_message = "No event media found, here is some media from that area!"
			values = seperate_values(event['event']['title'], ' ')
			@media = grab_all_media(values)
		end
		render :events
	end


	def find_event(event_id)
		$eb_client.event_get(id: event_id)
	end

end




