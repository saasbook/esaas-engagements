class CreateMatchings < ActiveRecord::Migration
  def change
    create_table :matchings do |t|

      t.timestamps null: false
    end
    add_column :matchings, :preference, :string
  end
end
