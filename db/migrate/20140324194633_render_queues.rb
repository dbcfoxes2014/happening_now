class RenderQueues < ActiveRecord::Migration
  def change
    create_table :render_queues do |t|
      t.string  :title
      t.string :job_id
      t.string :stage
      t.belongs_to :user

      t.timestamps
    end
  end
end
