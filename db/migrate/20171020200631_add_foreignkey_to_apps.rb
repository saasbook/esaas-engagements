class AddForeignkeyToApps < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  		t.references :app, index: true
  	end
  	add_foreign_key :comments, :apps
  end
end
