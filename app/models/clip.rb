class Clip < ActiveRecord::Base
	validates :file_path, presence: true

	belongs_to :video
end
