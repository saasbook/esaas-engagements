class CreationController < ApplicationController
    before_action :auth_user?, only: [:new, :create]

    def app_params
        params.require(:app).permit(:name, :description, :deployment_url,
            :repository_url, :code_climate_url, :org_id, :status, :comments)
    end

    def user_params
        params.require(:user).permit(:name, :email, :preferred_contact,
            :github_uid, :user_type, :sid,:developing_engagement_id, :coaching_org_id)
    end

    def org_params
        params.require(:org).permit(:name, :description, :url, :contact_id,
            :address_line_1, :address_line_2, :city_state_zip, :phone, :defunct)
    end

    def new
        @user = User.new
        @org = Org.new
        @app = App.new
    end

    def create
        begin
            ActiveRecord::Base.transaction do
                @user = User.create!(user_params)
                @org = @user.client_orgs.create!(org_params)
                @app = @org.apps.create!(app_params)
            end
        rescue ActiveRecord::RecordInvalid => e
            @error_record = e.record
            render :new, locals: {'@user': @user || User.new,
                '@org': @org || Org.new, '@app': @app ||App.new} and return
        end
        redirect_to app_path(@app), notice: 'User, Org, and App were successfully created.'
    end
end