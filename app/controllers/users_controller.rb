class UsersController < ApplicationController
  before_action :auth_user?, only: [:new, :create, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    total_user = User.count
    page_default_and_update("user",total_user)
    change_page_num("user",total_user)
    offset = @each_page*(@page_num-1) < 0 ? 0 : @each_page*(@page_num-1)
    @users = User.limit(@each_page).offset(offset)
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

  def import
    User.import(params[:file])
    redirect_to users_path, notice: 'User was successfully imported.'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.
      require(:user).
      permit(:name,:email,:preferred_contact,:github_uid,:user_type,:sid,
        :developing_engagement_id, :coaching_org_id, :profile_picture)
  end
end
