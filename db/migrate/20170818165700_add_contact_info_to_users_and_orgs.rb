class AddContactInfoToUsersAndOrgs < ActiveRecord::Migration
  def change
    %w(address_line_1 address_line_2 city_state_zip).each do |field|
      add_column :orgs, field, :string, :null => true, :default => nil
    end
    add_column :users, :preferred_contact, :string, :null => true, :default => nil
  end
end
