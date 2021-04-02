class CreateMatchings < ActiveRecord::Migration
  def change
    create_table :matchings do |t|
      t.string :preference, array: true, default: []
      t.timestamps null: false
    end
  end
end
