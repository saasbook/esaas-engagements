class AddSemesterToIterations < ActiveRecord::Migration
  def change
    add_column :engagements, :semester, :string
  end
end
