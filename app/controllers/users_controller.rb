class UsersController < ApplicationController
  before_action :auth_user?, only: [:new, :create, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @total_user = User.count
    @page_dict = {"10" => 10, "50" => 50, "100" => 100, "All" => User.count}
    session[:user_page_num] ||= '1'
    session[:user_each_page] = params[:user_each_page] || session[:user_each_page] || '10'
    session[:user_page_num] = '1' if params[:user_each_page]
    @each_page = @page_dict[session[:user_each_page]].to_i
    change_page_num
    @users = User.limit(@each_page).offset(@each_page*(@page_num-1))
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

  def change_page_num
    page_num = (params[:prev] || session[:user_page_num]).to_i
    max_page_num =  (@total_user - 1) / @each_page + 1 
    @page_num = {"Previous"=>page_num-1,"Next"=>page_num+1,"First"=>1,"Last"=>max_page_num,nil=>page_num}[params[:user_page_action]].to_i
    flash.now[:alert] = "You are already on the FIRST page." if @page_num == 0
    flash.now[:alert] = "You are already on the LAST page." if @page_num == max_page_num + 1
    @page_num = [[1,@page_num].max,max_page_num].min    
    session[:user_page_num] = @page_num.to_s
  end
end
