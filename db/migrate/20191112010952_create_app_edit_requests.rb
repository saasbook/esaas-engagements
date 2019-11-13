class CreateAppEditRequests < ActiveRecord::Migration
  def change
    create_table :app_edit_requests do |t|
      t.text :description
      t.text :features
      t.text :feedback
      t.integer :status, null: false, default: 0 # see app_edit_request.rb for enum types
      t.datetime :approval_time
      t.belongs_to :app, index: true, null: false, references: 'apps'
      t.belongs_to :requester, index: true, null: false, references: 'users'
      t.belongs_to :approver, index: true, references: 'users'
      t.timestamps null: false
    end
  end
end 