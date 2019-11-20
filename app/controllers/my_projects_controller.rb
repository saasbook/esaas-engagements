class MyProjectsController < ApplicationController
    before_filter :app_exists_and_belongs_to_user?, except: :index
    before_action :setup_form_vars, except: :index

    # GET /my_projects
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

    # GET /my_projects/edit/:app_id
    def edit
        redirect_to new_my_project_edit_path(app_id: params[:app_id]) and return  if @app_edit_request.nil?
        @staff_list = User.where(user_type: User.user_types[:coach]).order(name: :asc).all
    end

    # GET /my_projects/new/:app_id
    def new
        redirect_to edit_my_project_edit_path(app_id: params[:app_id]) unless @app_edit_request.nil?
    end

    # POST /my_projects/:app_id
    def create
        redirect_to edit_my_project_edit_path(app_id: params[:app_id]) and return unless @app_edit_request.nil?
        @app_edit_request = AppEditRequest.new(
            app_id:       params[:app_id],
            description:  params[:description],
            features:     params[:features],
            status:       :submitted,
            requester_id: session[:user_id]
        )
        if @app_edit_request.save
            redirect_to app_path(@app)
        else
            redirect_to new_my_project_edit_path(app_id: @app.id),
                        alert: @app_edit_request.errors.full_messages.join(" ") || 'Failed to create edit request.'
        end
    end

    # PUT /my_projects/:app_id
    def update
        redirect_to new_my_project_edit_path and return if @app_edit_request.nil?
        unless update_to_edit_made(@app_edit_request)
            redirect_to edit_my_project_edit_path, alert: 'There were no updates to edits made.'
            return
        end

        new_status = (@app_edit_request.submitted?) ? :submitted : :resubmitted
        updated = @app_edit_request.update_attributes(
            description: params[:description],
            features:    params[:features],
            status:      new_status,
        )
        if !updated
            redirect_to edit_my_project_edit_path(app_id: @app.id),
                        alert: @app_edit_request.errors.full_messages.join(" ") || 'Failed to save edit updates.'
        else
            redirect_to app_path(@app), notice: 'Successfully updated edit request.'
        end
    end

    def destroy
        if @app_edit_request.nil?
            redirect_to my_projects_path, alert: %Q{There is not edit request for app with id: #{params[:app_id]}}
            return
        end
        notice = if @app_edit_request.destroy
                    %Q{Successfully deleted edit request for: #{@app.name}}
                 else
                     @app_edit_request.errors.full_messages.join(" ") || %Q{Failed to delete edit request for: #{@app.name}}
                 end
        redirect_to my_projects_path, notice: notice
    end

    private
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

    def app_edit_request_params
        params.permit(:description, :features)
    end

    def setup_form_vars
        @app_edit_request = AppEditRequest.get_request_for(params[:app_id])
        @app            = App.where(id: params[:app_id]).first
        @description    = @app_edit_request&.description || @app.description
        @features       = @app_edit_request&.features || @app.features
        @banner_class   = ApplicationHelper.get_edit_req_banner_class @app_edit_request
        @banner_message = ApplicationHelper.get_edit_req_banner_message @app_edit_request
    end

    def app_exists_and_belongs_to_user?
        unless App.belongs_to_user params[:app_id], session[:user_id]
            flash.alert = "You do not have any projects with ID: #{params[:app_id]}."
            redirect_to(my_projects_path)
        end
    end

    def update_to_edit_made(app_edit_request)
        app_edit_request.description != params[:description] || app_edit_request.features != params[:features]
    end
end
