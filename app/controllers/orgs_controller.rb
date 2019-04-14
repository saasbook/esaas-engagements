class OrgsController < ApplicationController
  before_action :set_org, only: [:show, :edit, :update, :destroy]
  before_action :auth_user?, only: [:new, :create, :edit, :update, :destroy]

  # GET /orgs
  # GET /orgs.json
  def index
    @orgs = Org.all.includes(:apps)
  end

  # GET /orgs/new
  def new
    @org = Org.new
  end

  # Get /mail_all_orgs
def mail_all_orgs_form
end

 # Post /mail_all_orgs
def mail_all_orgs
  @sender_email = params[:email][:address]
  @subject = params[:email][:subject]
  @content = params[:email][:content]
  
  @vetting_checked = params.select {|k, v| v == "1"}.keys 
  @org_email = nil
  @org_name =  nil
  if not params['All'].nil?
    Org.all.each do |org|
        @org_email = app.org.contact.email
        @org_name = app.org.contact.name
        FormMailer.mail_to(@org_name, @org_email, @subject, @content, @sender_email).deliver_now
    end
  else
    App.all.each do |app|
      if @vetting_checked.include? app.status
        @org_email = app.org.contact.email
        @org_name = app.org.contact.name
      end
      if @org_email != nil && @org_name !=  nil
        FormMailer.mail_to(@org_name, @org_email, @subject, @content, @sender_email).deliver_now
      end
    end
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
    respond_to do |format|
      if @org.update(org_params)
        format.html { redirect_to orgs_path, notice: 'Org was successfully updated.' }
        format.json { render :show, status: :ok, location: @org }
      else
        format.html { render :edit }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy
    @org.destroy
    respond_to do |format|
      format.html { redirect_to orgs_url, notice: 'Org was successfully destroyed.' }
      format.json { head :no_content }
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