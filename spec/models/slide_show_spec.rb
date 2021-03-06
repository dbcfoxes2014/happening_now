require 'spec_helper'

describe SlideShow do
	it "is invalid without a user" do
		expect(build(:slide_show, user_id: nil)).not_to be_valid
	end

	it "is invalid without a title" do
  	expect(build(:slide_show, title: nil)).not_to be_valid
  end

	it "is invalid without a file_path" do
  	expect(build(:slide_show, file_path: nil)).not_to be_valid
  end
end
