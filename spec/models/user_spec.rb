require 'spec_helper'

describe User do
	it "has a valid factory" do
		expect(build(:user)).to be_valid
	end

  it "is valid with a first_name, last_name and email" do
  	expect(build(:user)).to be_valid
  end

  it "is invalid without a first_name" do
  	expect(build(:user, first_name: nil)).to \
  	have(1).errors_on(:first_name)
  end
  
  it "is invalid without a last_name" do
  	expect(build(:user, last_name: nil)).to \
  	have(1).errors_on(:last_name)
  end
  
  it "is invalid without an email address" do
  	user = FactoryGirl.build(:user, email: nil)
  	expect(user).to have(1).errors_on(:email)
  end
  
  it "is invalid with a duplicate email address" do
  	FactoryGirl.create(:user, email: "j@d.com")
  	user = FactoryGirl.build(:user, email: "j@d.com")
  	expect(user).to have(1).errors_on(:email)
  end
end