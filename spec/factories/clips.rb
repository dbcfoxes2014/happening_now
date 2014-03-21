require 'faker'

FactoryGirl.define do 
	factory :clip do |f|
		f.video { Faker::Number.digit}
		f.file_path { Faker::Internet.url('website.com', '/foobar.mp4')}
		f.is_private 0
		before(:create) do |video|
			clip.video_id << FactoryGirl.build(:video, clip: clip)
		end
	end 
end

