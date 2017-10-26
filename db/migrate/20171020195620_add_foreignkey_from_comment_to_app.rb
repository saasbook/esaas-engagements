class AddForeignkeyFromCommentToApp < ActiveRecord::Migration
  def change
  	add_foreign_key :comments, :apps
  end
end
