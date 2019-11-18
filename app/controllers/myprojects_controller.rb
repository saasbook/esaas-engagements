class MyprojectsController < ApplicationController
    skip_before_filter :logged_in?, :only => :index

    def index
        user = current_user
        orgs = Org.for_user(user.id)
        deploy_vet_map(orgs)
        total_app = @total_deploy + @total_vet
        page_default_and_update("myprojects", total_app)
        change_page_num("myprojects", total_app)
        @apps = App.for_orgs(orgs, limit=@each_page, offset=@each_page*(@page_num-1))
        respond_to do |format|
            format.json { render :json => @apps }
            format.html
        end
    end

    # GET /myprojects/1
    def show
        @current_user = User.find_by_id(session[:user_id])
        @current_user_orgs = Org.for_user(@current_user.id)
        @current_user_apps = App.for_orgs(@current_user_orgs)
        @current_request = AppEditRequest.find_by_app_id(params[:id])
        # Check if the specified app exists, and if it does, set it to @app
        if App.exists?(params[:id])
            @app = App.find(params[:id])
            @comments = @app.comments
        else
            flash.alert = "You do not have any projects with ID :#{params[:id]}."
            redirect_to myprojects_path and return
        end

        # Check if @app belongs to @current_user
        unless @current_user_apps.exists?(@app.id)
            flash.alert = "You do not have any projects with ID :#{params[:id]}."
            redirect_to myprojects_path
        end
    end

    def edit
        @app = App.find(params[:id])
        edit_request = AppEditRequest.find_by_app_id(params[:id])
        if edit_request&.description&.nil?
            @description = edit_request.description
        else
            @description = @app.description
        end

        if edit_request&.features&.nil?
            @features = edit_request.features
        else
            @features = @app.features
        end
    end

    def update
        @request = AppEditRequest.find_by_app_id(params[:id])
        if @request.nil?
            AppEditRequest.create!(:description => params[:description], :features => params[:features], :app_id => params[:id], :requester_id => session[:user_id])
        end
        redirect_to myproject_path(params[:id])
	end

    def deploy_vet_map(orgs=nil)
        status_map = App.status_count_for_orgs(orgs)
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
