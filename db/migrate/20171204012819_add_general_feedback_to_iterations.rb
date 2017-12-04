class AddGeneralFeedbackToIterations < ActiveRecord::Migration
  def change
    add_column :iterations, :general_feedback, :string
  end
end
