class AddPhoneToOrgs < ActiveRecord::Migration
  def change
    add_column :orgs, :phone, :string, :null => true, :default => nil
  end
end
