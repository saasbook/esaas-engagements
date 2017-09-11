class AddDefunctToOrgs < ActiveRecord::Migration
  def change
    add_column :orgs, :defunct, :boolean, :null => true, :default => false
  end
end
