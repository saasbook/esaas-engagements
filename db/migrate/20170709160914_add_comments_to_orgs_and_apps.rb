class AddCommentsToOrgsAndApps < ActiveRecord::Migration
  def change
    add_column :orgs, :comments, :text, :null => true, :default => nil
    add_column :apps, :comments, :text, :null => true, :default => nil
  end
end
