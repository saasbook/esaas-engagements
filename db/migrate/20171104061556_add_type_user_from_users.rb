class AddTypeUserFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :type_user, :string
  end
end
