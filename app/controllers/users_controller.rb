class UsersController < ApplicationController
  before_action :auth_user?, only: [:new, :create, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.
      require(:user).
      permit(:name,:email,:preferred_contact,:github_uid,:user_type,:sid,
        :developing_engagement_id, :coaching_org_id, :profile_picture)
  end
end
