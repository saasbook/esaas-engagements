class RemoveWhenFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :when, :datetime
  end
end
