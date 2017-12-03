class CreationController < ApplicationController

    def app_params
        params.require(:app).permit(:name, :description, :deployment_url, :repository_url, :code_climate_url, :org_id, :status, :comments)
    end

    def user_params
        params.require(:user).permit(:name,:email,:preferred_contact,:github_uid, :type_user, :sid)
    end

    def org_params
        params.require(:org).permit(:name, :description, :url, :contact_id, :comments, :address_line_1, :address_line_2, :city_state_zip, :phone, :defunct)
    end

    def new
        @user = User.new
        @org = Org.new
        @app = App.new
    end

    def create
        if User.find_by_id(session[:user_id]).type_user == "Staff"
            begin
                ActiveRecord::Base.transaction do
                    @user = User.create!(user_params)
                    @org = @user.orgs.create!(org_params)
                    @app = @org.apps.create!(app_params)
                end
            rescue ActiveRecord::RecordInvalid => e
                @error_record = e.record
                render :new and return
            end
            redirect_to app_path(@app), notice: 'User, Org, and App were successfully created.'
        else 
			redirect_to creation_path, alert: 'Error: Only Staff can create users, orgs, and apps'
		end
    end
end