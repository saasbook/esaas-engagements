class AddIterations < ActiveRecord::Migration
  def change
    create_table :iterations, :force => :cascade do |t|
      t.belongs_to :engagement
      t.text :customer_feedback
      t.datetime :end_date
      t.timestamps
    end
  end
end
