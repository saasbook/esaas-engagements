class AddPreferenceToMatching < ActiveRecord::Migration
  def change
    add_column :matchings, :preference, :text, array: true, default: []
  end
end
