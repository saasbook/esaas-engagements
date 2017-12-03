class RemoveContactIdAndCoachingOrgIdFromEngagements < ActiveRecord::Migration
  def change
    remove_column :engagements, :contact_id, :integer
    remove_column :engagements, :coaching_org_id, :integer
  end
end
