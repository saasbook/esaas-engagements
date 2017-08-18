class ApplicationController < ActionController::Base

  before_filter :logged_in?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def logged_in?
    redirect_to login_path and return unless
      (@current_user = User.find_by_id(session[:user_id])).kind_of?(User)
  end
end
