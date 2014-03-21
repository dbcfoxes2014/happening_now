FactoryGirl.define do 
	factory :clip do |f|
		f.video ""
		f.file_path "/../new_clip"
		f.is_private 0
	end 
end


