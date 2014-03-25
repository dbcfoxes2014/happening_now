require 'spec_helper'

describe HomeController do

	it "should have a current_user" do
    expect(subject.current_user).not_to be_nil
  end

  it "should get home#index" do
    get 'index'
    expect(response).to be_success
  end
end