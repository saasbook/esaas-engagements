class ChangeCommentsToCommentables < ActiveRecord::Migration
  def change
  	rename_column :comments, :app_id, :commentable_id
  	add_column :comments, :commentable_type, :string
  	remove_index :comments, :commentable_id
  	add_index :comments, [:commentable_type, :commentable_id]
  end
end
