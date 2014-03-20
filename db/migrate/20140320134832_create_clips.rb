class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
    	t.belongs_to :video
    	t.string :file_path
    	t.boolean :is_private, default: :false

      t.timestamps
    end
  end
end
