class AddPreferenceToMatching < ActiveRecord::Migration
  def change
    add_column :matchings, :preference, :text
  end
end
