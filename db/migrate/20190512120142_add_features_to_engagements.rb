class AddFeaturesToEngagements < ActiveRecord::Migration
  def change
    add_column :engagements, :features, :string
  end
end
