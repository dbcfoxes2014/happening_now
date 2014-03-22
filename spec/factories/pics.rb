require 'faker'

FactoryGirl.define do 
	factory :pic do |f|
		f.slide_show_id { Faker::Number.digit}
		f.file_path { Faker::Internet.url('website.com', '/foobar.jpg')}
		f.is_private 0
	end 
end
