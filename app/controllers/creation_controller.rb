class CreationController < ApplicationController

    def app_params
        params.require(:app).permit(:name, :description, :deployment_url, :repository_url, :code_climate_url, :org_id, :status, :comments)
    end 
    
    def user_params
        params.require(:user).permit(:name,:email,:preferred_contact,:github_uid)
    end
    
    def org_params
        params.require(:org).permit(:name, :description, :url, :contact_id, :comments, :address_line_1, :address_line_2, :city_state_zip, :phone, :defunct)
    end
    
    def new
    end

    def  create
        byebug
        @user = User.new(user_params)
        @org = Org.new(org_params)
        @app = App.new(app_params)
        
        respond_to do |format|
            user_errs = !@user.save
            org_errs = !@org.save
            app_errs = !@app.save
            if user_errs || org_errs || app_errs
                errs = []
                if user_errs
                    errs.push(@user.errors)
                    print @user.errors
                end
                if org_errs
                    errs.push(@org.errors)
                    print @org.errors
                end
                if app_errs
                    errs.push(@app.errors)
                    print @app.errors
                end
                format.html { render :new }
                format.json { render json: errs, status: :unprocessable_entity }
            else
                format.html { redirect_to app_path(@app), notice: 'User, Org, and App were successfully created.' }
            end
        end
    end
                

end