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
    if User.find_by_id(session[:user_id]).type_user == "Student"
      redirect_path
    end 
  end 
  
  def redirect_path
    command = @@name_path.first(5)
    if command == "/apps" # apps and their engagements path
      redirect_to apps_path, alert: 'Error: Only Staff can create, edit and destroy apps and engagements'
    elsif command == "/orgs"
      redirect_to orgs_path, alert: 'Error: Only Staff can create, edit and destroy orgs'
    elsif command == "/user"
      redirect_to users_path, alert: 'Error: Only Staff can create and edit users'
    elsif command == "/crea"
      redirect_to apps_path, alert: 'Error: Only Staff can create apps, orgs, users'
    elsif command == "/enga" #engagement's iteration path
      redirect_to part_path, alert: 'Error: Only Staff can create, edit and destroy apps, engagements and iterations' and return
    end
    return
  end 
  
  def part_path
    parts = @@name_path.split("/")
    "/" + parts[1] + "/" + parts[2] + "/" + parts[3]
  end 
  
end