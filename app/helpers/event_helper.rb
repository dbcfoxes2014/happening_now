module EventHelper
include SearchHelper

	def search_for_location_media(location)
		events = $eb_client.event_search(city: location)
		if events['events'][1]['event']['venue']
			if events['events'][1]['event']['venue']['name'].similar(location) > 60
					lat = events['events'][1]['event']['venue']['latitude']
					long = events['events'][1]['event']['venue']['longitude']
					binding.pry
					media = find_media_by_location(lat, long)
			end
		end
		media
	end
end