module SearchHelper

	def join_values(string)
		string.gsub!(/\W/, "")
	end

	def find_similar_tags(search_content)
		similar_media = []
		# values.each do |value|
			for item in Instagram.tag_search(search_content, {count: 4})
				similar_media << item.name
			end
		# end
		similar_media.sample(5)
	end

	def grab_all_media(values)
		session[:next_max_id] = []
		session[:search_terms] = values
		media = []

		values.each do |value|
			session[:next_max_id] << Instagram.tag_recent_media(value).pagination.next_max_id
			for item in Instagram.tag_recent_media(value)
				media << item
			end
		end
		media
	end

	def grab_select_media(values, wanted_type)
		session[:next_max_id] = []
		session[:search_terms] = values
		media = []

		values.each do |value|
			session[:next_max_id] << Instagram.tag_recent_media(value).pagination.next_max_id

			for item in Instagram.tag_recent_media(value)
				if item.type == wanted_type
					media << item
				end
			end
		end
		media
	end

	def grab_popular_media
	    session[:next_max_id] = []
	    session[:search_terms] = []

		media = []
		for item in Instagram.media_popular
				media << item
		end
		media
	end

	def find_user_media(user_id)
		media = []
		for item in Instagram.user_recent_media(user_id)
			media << item
		end
		media
	end

	def find_media_by_location(lat, long, start)
		media = []
		for item in Instagram.media_search(lat, long, MIN_TIMESTAMP: start, DISTANCE: 1)
			media << item
		end
		media
	end

	def find_media_by_venue(id)
		venue_search = Instagram.location_recent_media(id)
		media = []
		for item in venue_search
			media << item
		end
		media
	rescue URI::InvalidURIError
		media
	end

	def find_id_by_location(lat, long, venue)
		search = Instagram.location_search(lat, long)
		for item in search
			if item['name'].split('').sort.join('').strip.similar(venue) > 90
				return item['id']
			end
		end
		nil
	rescue Instagram::InternalServerError
		nil
	end

	def find_matching_event_names(list, event_name)
		events = []
		list.each do |event|
			if event['event']['venue']
				if event['event']['title'].split('').sort.join('').strip.similar(event_name) > 10
					events << event['event']
				elsif event['event']['venue']['name'].split('').sort.join('').strip.similar(event_name) > 10
					events << event['event']
				end
			end
		end
		events.uniq
		
	end

end


