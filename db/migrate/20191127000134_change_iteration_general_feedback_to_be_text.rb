class ChangeIterationGeneralFeedbackToBeText < ActiveRecord::Migration
  def change
    change_column :iterations, :general_feedback, :text
  end
end
