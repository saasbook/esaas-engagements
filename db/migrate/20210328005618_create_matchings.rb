class CreateMatchings < ActiveRecord::Migration
  def change
    create_table :matchings do |t|
      t.timestamps null: false
      t.string :name
      t.text :preferences
      t.text :teams
      t.text :projects
      t.text :description
      t.text :result
      t.string :status, null: false, default: 'Collecting Responses'
    end
  end
end
