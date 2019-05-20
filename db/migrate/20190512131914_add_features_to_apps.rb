class AddFeaturesToApps < ActiveRecord::Migration
  def change
    add_column :apps, :features, :text
  end
end
