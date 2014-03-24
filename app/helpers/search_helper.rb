module SearchHelper

	def seperate_values(string, delim)
		string.delete!("#")
		string.split(delim)
	end

	def find_similar_tags(values)
		#session variables used for pagination
		session[:search_terms] = values
		session[:max_ids] = nil

		similar_media = []
		values.each do |value|
			for item in Instagram.tag_search(value, {count: 4})
				similar_media << item.name
			end
		end
		similar_media.sample(5)
	end

	def grab_all_media(values)
		#session variables used for pagination
		session[:search_terms] = values
		session[:max_ids] = nil

		media = []
		values.each do |value|
			for item in Instagram.tag_recent_media(value)
				media << item
			end
		end
		media
	end

	def grab_select_media(values, wanted_type)
		#session variables used for pagination
		session[:search_terms] = values
		session[:max_ids] = nil

		media = []
		values.each do |value|
			for item in Instagram.tag_recent_media(value)
				if item.type == wanted_type
					media << item
				end
			end
		end

		media
	end

	def grab_popular_media
		media = []
		for item in Instagram.media_popular
				media << item
		end
		media
	end

end
