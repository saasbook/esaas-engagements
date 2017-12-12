class RemoveTypeUserFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :type_user, :string
  end
end
