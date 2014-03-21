FactoryGirl.define do 
	factory :user do |f|
		f.first_name "Jack"
		f.last_name "Dubnicek"
		f.email "j@d.com"
		f.encrypted_password "123"
	end 
end