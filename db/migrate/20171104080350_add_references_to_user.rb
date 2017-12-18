class AddReferencesToUser < ActiveRecord::Migration
  def change
    add_reference :users, :engagement, index: true, foreign_key: true
  end
end
