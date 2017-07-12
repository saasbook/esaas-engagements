class AddCodeClimateUrlToApps < ActiveRecord::Migration
  def change
    add_column :apps, :code_climate_url, :string, :null => true, :default => nil
  end
end
