class SlideShow < ActiveRecord::Base
	belongs_to :user
	has_many :pics
end
