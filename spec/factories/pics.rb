FactoryGirl.define do 
	factory :pic do |f|
		f.slide_show ""
		f.file_path "/new_pic"
		f.is_private 0
	end 
end

