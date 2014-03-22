class AddThumbnailColumnToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :thumbnail_path, :string
  end

  def self.down
    remove_column :videos, :thumbnail_path
  end
end
