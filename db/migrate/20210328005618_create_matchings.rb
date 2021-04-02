class CreateMatchings < ActiveRecord::Migration
  def change
    create_table :matchings do |t|
      t.text :preference, array: true, default: []
      t.timestamps null: false
    end
  end
end
