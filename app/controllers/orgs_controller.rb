class OrgsController < ApplicationController
  
  before_action :set_org, only: [:show, :edit, :update, :destroy]

  # GET /orgs
  # GET /orgs.json
  def index
    @orgs = Org.all.includes(:apps)
  end

  # GET /orgs/new
  def new
    print User.find_by_id(session[:user_id]).github_uid
    if User.find_by_id(session[:user_id]).type_user == "Staff"
			@org = Org.new
		else 
			redirect_to orgs_path, alert: 'Error: Only Staff can create orgs'
		end
  end

  # GET /orgs/1/edit
  def edit
  end

  # POST /orgs
  # POST /orgs.json
  def create
    @org = Org.new(org_params)

    respond_to do |format|
      if @org.save
        format.html { redirect_to orgs_path, notice: 'Org was successfully created.' }
        format.json { render :show, status: :created, location: @org }
      else
        format.html { render :new }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orgs/1
  # PATCH/PUT /orgs/1.json
  def update
    if User.find_by_id(session[:user_id]).type_user == "Staff"
			respond_to do |format|
        if @org.update(org_params)
          format.html { redirect_to orgs_path, notice: 'Org was successfully updated.' }
          format.json { render :show, status: :ok, location: @org }
        else
          format.html { render :edit }
          format.json { render json: @org.errors, status: :unprocessable_entity }
        end
      end
		else 
			redirect_to orgs_path, alert: 'Error: Only Staff can update orgs'
		end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy
    if User.find_by_id(session[:user_id]).type_user == "Staff"
			@org.destroy
      respond_to do |format|
        format.html { redirect_to orgs_url, notice: 'Org was successfully destroyed.' }
        format.json { head :no_content }
      end
		else 
			redirect_to orgs_path, alert: 'Error: Only Staff can destroy orgs'
		end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def org_params
      params.
        require(:org).
        permit(:name, :description, :url, :contact_id,
      :address_line_1, :address_line_2, :city_state_zip, :phone, :defunct, coach_ids: [])
    end
end
