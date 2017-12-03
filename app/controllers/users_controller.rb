class UsersController < ApplicationController
  skip_before_action :auth_user?
  
  def index
    @users = User.all
  end

  def new
    if User.find_by_id(session[:user_id]).type_user == "staff"
			@user = User.new
      render 'user'
		else 
			redirect_to users_path, alert: 'Error: Only staff can create users'
		end
  end

  def edit
    if User.find_by_id(session[:user_id]).type_user == "staff"
      @user = User.find params[:id]
      render 'user'
    else 
			redirect_to users_path, alert: 'Error: Only staff can edit users'
		end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User successfully created.'
    else
      render 'user'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render 'user'
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.
      require(:user).
      permit(:name, :email, :preferred_contact, :github_uid, :user_type, :sid,
        :developing_engagement_id, :coaching_org_id)
  end
end

