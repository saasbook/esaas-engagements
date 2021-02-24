class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  skip_before_filter :logged_in?, :only => :index
  skip_before_filter :auth_user?, :only => :index

  # GET /apps
  # GET /apps.json
  def index
    deploy_vet_map
    total_app = @total_deploy + @total_vet
    @current_user = User.find_by_id(session[:user_id])
    page_default_and_update("app", total_app)
    change_page_num("app", total_app)

    # Check to see if params already has deployment statuses
    contains_at_least_one_status = false
    App.getAllDeploymentStatuses.each do |status|
      if params.key? status
        contains_at_least_one_status = true
        break
      end
    end

    # Add deployment statuses to params if not already existing
    @deployment_statuses = Hash.new
    if not contains_at_least_one_status
      # First time: add all statuses to params
      App.getAllDeploymentStatuses.each do |status|
        params[status] = 1
        @deployment_statuses = params
      end
    else
      App.getAllDeploymentStatuses.each do |status|
        # Get existing statuses from params
        if params.key? status
          @deployment_statuses = params
        end
      end
    end

    # Repeat for Vetting STATUSES
    contains_at_least_one_v_status = false
    App.getAllVettingStatuses.each do |status|
      if params.key? status
        contains_at_least_one_v_status = true
        break
      end
    end

    @vetting_statuses = Hash.new
    if not contains_at_least_one_v_status
      App.getAllVettingStatuses.each do |status|
        params[status] = 1
        @vetting_statuses = params
      end
    else
      App.getAllVettingStatuses.each do |status|
        if params.key? status
          @vetting_statuses = params
        end
      end
    end

    puts "CURRENT DEPLOYMENT STATUSES IN PARAMS"
    puts params

    @filtered_count = 0
    App.find_each do |app|
      if @deployment_statuses.key? app.status.to_sym
        @filtered_count += 1
      end
    end

    @apps = App.limit(@each_page).offset(@each_page*(@page_num-1))
    respond_to do |format|
      format.json { render :json => @apps.featured }
      format.html
    end
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    @app_edit_request = ApplicationHelper.get_edit_request_for session[:user_id], params[:id]
    @user_owns_app = App.belongs_to_user(params[:id], session[:user_id])
    @iterations = App.find(params[:id]).iterations
  end

  # GET /apps/new
  def new
    if User.find_by_id(session[:user_id]).coach?
      @app = App.new
    else
      redirect_to apps_path, alert: 'Error: Only Staff can create an app'
    end
  end

  # GET /apps/1/edit
  def edit
    if User.find_by_id(session[:user_id]).coach?
      @comments = App.find_by_id(params[:id]).comments
    else
      redirect_to apps_path, alert: 'Error: Only Staff can edit an app'
    end
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(app_params)

    respond_to do |format|
      if @app.save
        format.html { redirect_to apps_path, notice: 'App was successfully created.' }
        format.json { render :show, status: :created, location: @app }
      else
        format.html { render :new }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to apps_path, notice: 'App was successfully updated.' }
        format.json { render :show, status: :ok, location: @app }
      else
        format.html { render :action => :edit }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    if User.find_by_id(session[:user_id]).coach?
      @app.destroy
      respond_to do |format|
        format.html { redirect_to apps_url, notice: 'App was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to apps_path, alert: 'Error: Only Staff can destroy an app'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_app
    @app = App.find(params[:id])
    @engagements = @app.engagements
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def app_params
    params.require(:app).permit(:name, :description, :deployment_url, :repository_url,
                              :code_climate_url, :org_id, :status, :comments, :features,
                              :pivotal_tracker_url)
  end

  # count the number of apps for each status and
  # the total number of apps for each category
  def deploy_vet_map
    status_map =  App.group(:status).reorder(:status).count # should be in model?
    @deployment_map = {}
    @vetting_map = {}
    @total_deploy = 0
    @total_vet = 0
    status_map.each do |status, count|
      status_str = App.statuses.keys[status]
      if App.getAllVettingStatuses.include? status_str.to_sym
        @vetting_map[status_str] = count
        @total_vet += count
      else
        @deployment_map[status_str] = count
        @total_deploy += count
      end
    end
  end
end
