class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true
	belongs_to :user

	validates_presence_of :content, :commentable, :user_id

	default_scope { order(:created_at => :asc) }

	def comment_type_name
		comment_type ? commentable.class.comment_types.keys[comment_type] : nil
	end
end
