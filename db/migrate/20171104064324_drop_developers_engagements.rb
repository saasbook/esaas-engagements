class DropDevelopersEngagements < ActiveRecord::Migration
  def change
    drop_table :developers_engagements
  end
end
