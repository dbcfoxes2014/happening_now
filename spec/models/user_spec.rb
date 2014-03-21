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
  
  it "is invalid without a last_name"
  it "is invalid without an email address"
  it "is invalid with a duplicate email address"
  #it "returns a contact's full name as a string"
end