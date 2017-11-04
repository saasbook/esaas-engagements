class AddSidToUser < ActiveRecord::Migration
  def change
    add_column :users, :sid, :string
  end
end
