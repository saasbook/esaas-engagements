class Apps::CommentsController < CommentsController
	before_action :set_commentable

private
	def set_commentable
		@commentable = App.find(params[:app_id])
	end
end