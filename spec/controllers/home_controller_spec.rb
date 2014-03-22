require 'spec_helper'

describe HomeController do

	# before(:all) do
	# 	@user = FactoryGirl.create(:user)
	# 	sign_in user
	# end

	# context "home#index" do

	# 	it "loads successfully" do
	# 		expect(response(:root)).to be_success
	# 	end
	# end

	it "should have a current_user" do
    expect(subject.current_user).not_to be_nil
  end

  it "should get home#index" do
    get 'index'
    expect(response).to be_success
  end
end