class CreateSlideShows < ActiveRecord::Migration
  def change
    create_table :slide_shows do |t|
    	t.belongs_to :user
    	t.string :title
    	t.string :file_path

      t.timestamps
    end
  end
end
