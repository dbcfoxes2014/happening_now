module SearchHelper

	def seperate_values(string, delim)
		string.split(delim)
	end

	def grab_all_media(values)
		media = []
		values.each do |value|
			for item in Instagram.tag_recent_media(value)
				media << item
			end
		end
		media
	end

	def grab_select_media(values, wanted_type)
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

end