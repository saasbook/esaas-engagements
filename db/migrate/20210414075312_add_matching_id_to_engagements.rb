class AddMatchingIdToEngagements < ActiveRecord::Migration
  def change
    add_column :engagements, :matching_id, :integer
  end
end
