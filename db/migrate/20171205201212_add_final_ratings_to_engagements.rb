class AddFinalRatingsToEngagements < ActiveRecord::Migration
  def change
    add_column :engagements, :final_rating, :string
    add_column :engagements, :final_comments, :string
  end
end
