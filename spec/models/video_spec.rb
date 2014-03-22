require 'spec_helper'

describe Video do
	it "is invalid without a user" do
		expect(build(:video, user_id: nil)).not_to be_valid
	end

	it "is invalid without a title" do
  	expect(build(:video, title: nil)).not_to be_valid
  end

	it "is invalid without a file_path" do
  	expect(build(:video, file_path: nil)).not_to be_valid
  end
end
