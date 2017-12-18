class AddCoachingOrgIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coaching_org_id, :integer
  end
end
