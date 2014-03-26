module SearchHelper

	def join_values(string)
		return string.gsub(/\W/, "")
	end

	def seperate_values(string)
		
	end

	def find_similar_tags(value)
		similar_media = []
			for item in Instagram.tag_search(value, {count: 4})
				similar_media << item.name
			end
		similar_media.sample(5)
	end

	def grab_all_media(values)
		session[:next_urls] = []
		media = []

		if values.class == String
			values = values.split()
		end

		values.each do |value|
			session[:next_urls] << Instagram.tag_recent_media(value).pagination.next_url
			for item in Instagram.tag_recent_media(value)
				media << item
			end
		end
		media
	rescue URI::InvalidURIError
		media
	end

	def grab_select_media(values, wanted_type)
		session[:next_urls] = []

		media = []

		values.each do |value|
			session[:next_urls] << Instagram.tag_recent_media(value).pagination.next_url
			for item in Instagram.tag_recent_media(value)
				if item.type == wanted_type
					media << item
				end
			end
		end
		media
	rescue URI::InvalidURIError
		media
	end

	def grab_popular_media
	  session[:next_url] = []

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

	def get_instagram_user
		Instagram.user_search(params[:username])
	end
end


