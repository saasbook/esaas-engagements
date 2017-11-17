class Orgs::CommentsController < CommentsController
	before_action :set_commentable

private
	def set_commentable
		@commentable = Org.find(params[:org_id])
	end
end