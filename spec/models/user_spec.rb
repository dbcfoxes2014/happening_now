require 'spec_helper'

describe User do
  it "is valid with a first_name, last_name and email" do
  	user = User.new(
  		first_name: 'Jack',
  		last_name: 'Dubnicek,
  		email: j@d.com')
  	expect(user).to be_valid
  end

  it "is invalid without a first_name" do
  	user = User.new(
  		first_name = "")
  	expect(user).to be_invalid
  end
  
  it "is invalid without a last_name" do
  	user = User.new(
  		last_name = "")
  	expect(user).to be_invalid
  end
  
  it "is invalid without an email address" do
  	user = User.new(
  		email = "")
  	expect(user).to be_invalid
  end
  
  it "is invalid with a duplicate email address" do
  	user = User.new(
  		:email, uniqueness: :false)
  	expect(user).to be_invalid
  end
end