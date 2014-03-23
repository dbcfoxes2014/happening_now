class CreateFlaggedContents < ActiveRecord::Migration
  def change
    create_table :flagged_contents do |t|
      t.belongs_to :user
      t.string :url
      t.string :thumbnail

      t.timestamps
    end
  end
end
