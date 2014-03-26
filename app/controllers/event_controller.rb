class EventController < ApplicationController
	include SearchHelper
  respond_to :json

<<<<<<< HEAD
	eb_client = EventbriteClient.new(eb_auth_tokens)

	# API Request
	# initialize our http object, for contacting the API
	http = Net::HTTP.new('www.eventbrite.com', 443)
	http.use_ssl=true


	#make our API request - 
	
	#parse our JSON response data...

=======
>>>>>>> 78cf92650655347e7824ee3e5c10a660f233ddb9
	def popular_events
		response = $eb_client.event_search(date: "Last Week")
		@e = JSON.parse(response.body)
		@e["events"].delete_at(0)
		# binding.pry

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
				@media = find_media_by_location(event['event']['venue']['latitude'], event['event']['venue']['longitude'], event['event']['start_date'])
			else
				@media = find_media_by_venue(venue_id)
			end
		else
			values = seperate_values(event['event']['title'], ' ')
			@media = grab_all_media(values)
		end
		render :events
	end


	def find_event(event_id)
		$eb_client.event_get(id: event_id)
	end

end




