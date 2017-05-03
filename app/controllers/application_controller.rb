class ApplicationController < ActionController::Base
  http_basic_authenticate_with(:name => Figaro.env.auth_user!, :password => Figaro.env.auth_pass!, :only => [:create,:update,:destroy]) if Rails.env.production?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
