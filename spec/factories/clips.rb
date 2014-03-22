require 'faker'

FactoryGirl.define do 
	factory :clip do |f|
		f.video_id { Faker::Number.digit}
		f.file_path { Faker::Internet.url('website.com', '/foobar.mp4')}
		f.is_private 0
	end 
end

