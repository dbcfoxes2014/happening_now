require 'spec_helper'

describe SlideShow do
	it "is invalid without a user" do
		expect(build(:slide_show, user_id: nil)).to \
		have(1).errors_on(:user_id)
	end

	it "is invalid without a title" do
  	expect(build(:slide_show, title: nil)).to \
  	have(1).errors_on(:title)
  end

	it "is invalid without a file_path" do
  	expect(build(:slide_show, file_path: nil)).to \
		have(1).errors_on(:file_path)
  end
end
