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
  	expect(User.new(first_name: nil)).to have(1).errors_on(:first_name)
  end
  
  it "is invalid without a last_name" do
  	expect(User.new(last_name: nil)).to have(1).errors_on(:last_name)
  end
  
  it "is invalid without an email address" do
  	expect(User.new(email: nil)).to have(1).errors_on(:email)
  end
  
  it "is invalid with a duplicate email address" do
  	User.create(
  		first_name: 'Jack', last_name: 'Dubnicek',
  			email: 'j@d.com')
  	user = User.new(
  		first_name: 'John', last_name: 'Donner'
  			email: 'j@d.com')
  	expect(user).to have(1).errors_on(:email)
  end
end