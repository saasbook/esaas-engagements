class OrgsController < ApplicationController
  before_action :set_org, only: [:show, :edit, :update, :destroy]
  before_action :auth_user?, only: [:new, :create, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:import]

  # GET /orgs
  # GET /orgs.json
  def index
    total_org = Org.count
    page_default_and_update("org",total_org)
    change_page_num("org",total_org)
    offset = @each_page*(@page_num-1) < 0 ? 0 : @each_page*(@page_num-1)
    @orgs = Org.includes(:apps).limit(@each_page).offset(offset)
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
    # email to all selected organizations
    # if no checkbox selected, send nothing;
    # can specify reply_to address, subject and content
    @sender_email = params[:email][:address]
    @subject = params[:email][:subject]
    @content = params[:email][:content]

    @vetting_checked = params.select {|_, v| v == "1"}.keys
    @org_email = nil
    @org_name =  nil
    nothing_to_send = @vetting_checked.empty? && params['All'].nil?
    if nothing_to_send
      redirect_to orgs_path, alert: "Please select at least one box"
    else
      send_mail
      redirect_to orgs_path, notice: 'Sent successfully.'
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

  def import
    begin
      Org.import(params[:file])
      redirect_to orgs_path, notice: 'Org was successfully imported.'
    rescue StandardError => e  
      redirect_to orgs_path, notice: e.message
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

    def send_mail
      if not params['All'].nil? # all organizations selected
        Org.all.each do |org|
            @org_email = org.contact.email
            @org_name = org.contact.name
            FormMailer.mail_to(@org_name, @org_email, @subject, @content, @sender_email).deliver_now
        end
      else # selected apps in certain vetting stages
        App.all.each do |app|
          if @vetting_checked.include? app.status
            @org_email = app.org.contact.email
            @org_name = app.org.contact.name
            FormMailer.mail_to(@org_name, @org_email, @subject, @content, @sender_email).deliver_now
          end
        end
      end
    end
end
