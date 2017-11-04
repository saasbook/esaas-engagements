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

    def  create
        # byebug
        # create user, check error. if error. re-render 
        # create the org, check error, if error, DELETE USER@@@@
        # create the app, check error, if error, DELETE THE USER AND ORG@@@@@@

        #why am i getting rid of @model specific models again? llolol

        @user = User.new(user_params)
        no_user_err = @user.save
        if !no_user_err
            @errors = @user.errors.full_messages
            render :new and return
        end

        @org = Org.new(org_params.merge(:contact => @user))
        no_org_err = @org.save
        if !no_org_err
            @errors = @org.errors.full_messages
            @user.destroy
            render :new and return
        end

        @app = App.new(app_params.merge(:org_id => @org.id))
        no_app_err = @app.save
        if !no_app_err
            @errors = @app.errors.full_messages
            @user.destroy
            @org.destroy
            render :new and return
        end
        
        redirect_to app_path(@app), notice: 'User, Org, and App were successfully created.'
    end
                

end