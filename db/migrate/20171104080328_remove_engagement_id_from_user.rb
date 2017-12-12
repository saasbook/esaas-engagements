class RemoveEngagementIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :engagement_id, :integer
  end
end
