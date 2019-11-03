class AddTrackerColumnToApp < ActiveRecord::Migration
  def change
    add_column :apps, :pivotal_tracker_url, :string
  end
end
