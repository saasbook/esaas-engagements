class CommentsController < ApplicationController
	before_action :logged_in?
	before_action :set_comment, only: [:edit, :destroy, :update]
	before_action :authenticate, only: [:edit, :destroy, :update]

	def create
		@comment = @commentable.comments.new(comment_params)
		@comment.user = @current_user
		unless @comment.save
			render "/#{@commentable.model_name.plural}/show",
			locals: {"@#{@commentable.model_name.singular}": @commentable.reload, '@comment': @comment} and return
		end
		redirect_to @commentable, notice: "Comment was successfully created"
	end

	def destroy
		@comment.destroy
		redirect_to @comment.commentable
	end

	def update
		unless @comment.update(comment_params)
			render :edit and return
		end
		redirect_to @comment.commentable, notice: "Comment was successfully created"
	end

private
	def comment_params
		params.require(:comment).permit(:content, :comment_type)
	end

	def authenticate
		unless @comment.user_id == session[:user_id]
			flash[:alert] = "You don't have authorization to #{@comment.user.name}'s comment!"
			redirect_to @comment.commentable
		end
	end

	def set_comment
		@comment = Comment.find params[:id]
	end
end