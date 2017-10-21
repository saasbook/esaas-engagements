class CommentsController < ApplicationController
	def new
		@comment = Comment.new
	end

	def create
		if params["comment"]["content"] =~ /^\s*$/
			flash[:error] = "Comment cannot be empty!"
			redirect_to app_path(params[:app_id]) and return
		end
		@comment = App.find(params[:app_id]).comments.create!(comment_params)
		@comment.update_attributes(:username => User.find(session[:user_id]).name, :user_id => session[:user_id])
		redirect_to app_path(@comment.app_id)
	end

	def edit
		@comment = Comment.find(params[:id])
		if @comment.user_id != session[:user_id]
			flash[:error] = "You don't have authorization to edit #{@comment.username}'s comment!"
			redirect_to app_path(@comment.app_id)
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		if @comment.user_id != session[:user_id]
			flash[:error] = "You don't have authorization to delete #{@comment.username}'s comment!"
			redirect_to app_path(@comment.app_id)
		else
			@comment.destroy
			redirect_to app_path(@comment.app_id)
		end
	end

	def update
		@comment = Comment.find params[:id]
		@comment.update_attributes!(comment_params)
		redirect_to app_path(@comment.app_id)
	end

	def comment_params
		params.require(:comment).permit(:username, :user_id, :content, :app_id)
    end
end
