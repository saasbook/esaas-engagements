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

    def show
        @app = App.find(params[:id])
        @comments = @app.comments
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