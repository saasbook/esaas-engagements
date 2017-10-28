class AddRepoUrlToEngagements < ActiveRecord::Migration
  def change
  	add_column :engagements, :repository_url, :string
  end
end
