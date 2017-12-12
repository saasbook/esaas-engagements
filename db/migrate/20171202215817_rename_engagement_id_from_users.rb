class RenameEngagementIdFromUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :engagement_id, :developing_engagement_id
  end
end
