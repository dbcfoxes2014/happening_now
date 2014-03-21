require 'spec_helper'

describe Pic do
	it "is invalid without a file_path" do
  	expect(Pic.new(file_path: nil)).to have(1).errors_on(:file_path)
  end
end


