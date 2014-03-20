class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.belongs_to :user
    	t.string :title
    	t.string :file_path

      t.timestamps
    end
  end
end
