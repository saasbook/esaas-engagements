class RemoveCommentsFromOrgs < ActiveRecord::Migration
  def change
    remove_column :orgs, :comments, :text
  end
end
