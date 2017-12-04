class Users::CommentsController < CommentsController
	before_action :set_commentable

private
	def set_commentable
		@commentable = User.find(params[:user_id])
	end
end