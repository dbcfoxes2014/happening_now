module SearchHelper

	def seperate_values(string, delim)
		string.delete!("#")
		string.split(delim)
	end

	def find_similar_tags(values)
		similar_media = []
		values.each do |value|
			for item in Instagram.tag_search(value, {count: 4})
				similar_media << item.name
			end
		end
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

end
	
