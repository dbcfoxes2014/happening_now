class Pic < ActiveRecord::Base
	belongs_to :slide_show

	validates :file_path, presence: true
end
