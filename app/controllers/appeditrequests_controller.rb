class AppeditrequestsController < ActionController::Base
  before_action :auth_user?

  def index
    @requests = AppEditRequest.all
    respond_to do |format|
      format.json { render :json => AppEditRequest.featured }
      format.html
    end
  end

  def auth_user?
    User.find_by_id(session[:user_id])&.coach?
  end

end
