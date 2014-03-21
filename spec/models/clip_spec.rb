require 'spec_helper'

describe Clip do
	it "is invalid without a title" do
  	expect(Clip.new(title: nil)).to have(1).errors_on(:title)
  end

	it "is invalid without a file_path" do
  	expect(Clip.new(file_path: nil)).to have(1).errors_on(:file_path)
  end
end


