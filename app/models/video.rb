class Video < ActiveRecord::Base
	belongs_to :user
	has_many :clips

	validates :user_id, :title, :file_path, presence: true
end
