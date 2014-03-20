class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
    	t.belongs_to :slide_show
    	t.string :file_path
    	t.boolean :is_private, default: :false

      t.timestamps
    end
  end
end
