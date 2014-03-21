require 'faker'

FactoryGirl.define do 
	factory :slide_show do |f|
		f.user_id { Faker::Number.digit}
		f.title { Faker::Name.title}
		f.file_path { Faker::Internet.url('website.com', '/foobar.jpg')}
	end 
end
