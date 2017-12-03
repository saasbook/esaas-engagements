class ApplicationController < ActionController::Base
  before_filter :logged_in?
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  @@name_path = nil
  
   

  def logged_in?
    @@name_path = request.env['PATH_INFO']
    redirect_to login_path and return unless
      (@current_user = User.find_by_id(session[:user_id])).kind_of?(User)
  end
  
  def auth_user?
    if User.find_by_id(session[:user_id]).type_user != "Staff"
      redirect_to orgs_path and return
    end 
  end 
end