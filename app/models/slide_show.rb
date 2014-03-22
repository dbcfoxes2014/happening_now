class SlideShow < ActiveRecord::Base
	belongs_to :user
	has_many :pics

	validates :user_id, :title, :file_path, presence: true
end
