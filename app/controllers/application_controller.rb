class ApplicationController < ActionController::Base
  before_filter :logged_in?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :app_owner
  helper_method :get_pending_requests_count
  private
  @@name_path = nil

  def logged_in?
    @@name_path = request.env['PATH_INFO']
    redirect_to login_path and return unless
        (@current_user = User.find_by_id(session[:user_id])).kind_of?(User)
  end

  def auth_user?
    redirect_path unless User.find_by_id(session[:user_id])&.coach?
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def redirect_path
    if @@name_path&.first(5) == "/apps"
      redirect_helper(apps_path, 'Error: Only Staff can create, edit and destroy apps and engagements')
    elsif @@name_path&.first(5) == "/orgs"
      redirect_helper(orgs_path, 'Error: Only Staff can create, edit and destroy orgs')
    elsif @@name_path&.first(5) == "/user"
      redirect_helper(users_path, 'Error: Only Staff can create and edit users')
    elsif @@name_path&.first(5) == "/crea"
      redirect_helper(apps_path, 'Error: Only Staff can create apps, orgs, users')
    elsif @@name_path&.first(5) == "/enga"
      parts = @@name_path&.split("/")
      path = "/" + parts[1] + "/" + parts[2] + "/" + parts[3]
      redirect_helper(path, 'Error: Only Staff can create, edit and destroy apps, engagements and iterations')
    end
    return
  end

  def redirect_helper(path, msg)
    redirect_to path, alert: msg
  end

  def page_default_and_update(name, total_item)
      @page_dict = {"10" => 10, "50" => 50, "100" => 100, "All" => total_item}
      session["#{name}_page_num"] ||= '1'
      session["#{name}_each_page"] = params["#{name}_each_page"] || session["#{name}_each_page"] || '10'
      session["#{name}_page_num"] = '1'if params["#{name}_each_page"]
      @each_page = @page_dict[session["#{name}_each_page"]].to_i
  end

  def change_page_num(name, total_item)
    page_num = (params[:prev] || session["#{name}_page_num"]).to_i
    max_page_num =  (total_item - 1) / @each_page + 1
    @page_num = {"Previous"=>page_num-1,"Next"=>page_num+1,"First"=>1,"Last"=>max_page_num, nil => page_num}[params["#{name}_page_action"]].to_i
    flash.now[:alert] = "You are already on the FIRST page." if @page_num == 0
    flash.now[:alert] = "You are already on the LAST page." if @page_num == max_page_num + 1
    @page_num = [[1,@page_num].max,max_page_num].min
    session["#{name}_page_num"] = @page_num.to_s
  end
  
  def app_owner(app_id)
    current_user.app_ids.include? app_id unless current_user.student?
  end

  def get_pending_requests_count
    @pending_requests_count = AppEditRequest.where.not(status: 1).count
  end
end