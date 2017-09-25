class CreatePendingFeedbacks < ActiveRecord::Migration
  def change
    create_table :pending_feedbacks do |t|
      t.integer :engagement_id
      t.integer :iteration_id

      t.timestamps null: false
    end
  end
end
