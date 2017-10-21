class AddUseridToComment < ActiveRecord::Migration
  def change
    add_column :comments, :userid, :integer
  end
end
