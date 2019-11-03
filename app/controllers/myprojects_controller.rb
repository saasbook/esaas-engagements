class MyprojectsController < ApplicationController
    
    def index
        @current_user = User.find_by_id(session[:user_id])
        orgs = Org.for_user(params[:contact_id])
        @apps = App.for_orgs(orgs, limit=@each_page, offset=0).sort_by_status
        deploy_vet_map(@current_user.id)
        
        total_app = @total_deploy + @total_vet
        page_default_and_update("app", total_app)
        change_page_num("app", total_app)
        respond_to do |format|
            format.json { render :json => @apps.featured }
            format.html
        end
    end

    # GET /myprojects/1
    def show
        @current_user = User.find_by_id(session[:user_id])
        @current_user_orgs = Org.for_user(@current_user.id)
        @current_user_apps = App.for_orgs(@current_user_orgs)

        # Check if the specified app exists, and if it does, set it to @app
        # TODO: If the app does not exist, redirect and flash error.
        if App.exists?(params[:id])
            @app = App.find(params[:id])
            @comments = @app.comments
        else
            flash.alert = "You do not have any projects with ID:#{params[:id]}."
            redirect_to myprojects_path
            return
        end

        # Check if @app belongs to @current_user
        # TODO: If the app does not belong to the user, redirect and flash error.
        if !@current_user_apps.exists?(@app.id)
            flash.alert = "You do not have any projects with ID:#{params[:id]}."
            redirect_to myprojects_path
            return
        end
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