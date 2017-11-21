class AddIterationNumber < ActiveRecord::Migration
  def change
    add_column :iterations, :number, :string
  end
end
