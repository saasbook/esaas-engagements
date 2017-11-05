class EngagementsController < ApplicationController
  before_action :set_app
  before_action :set_engagement, only: [:edit, :update, :destroy]

  # GET /engagements
  # GET /engagements.json
  def index
    @engagements = Engagement.where(:app_id => @app.id)
  end

  # GET /engagements/new
  def new
    @engagement = Engagement.new
  end

  # GET /engagements/1/edit
  def edit
  end

  # POST /engagements
  # POST /engagements.json
  def create
    @engagement = @app.engagements.build(engagement_params)
    if @engagement.save
      redirect_to @app, notice: 'Engagement was successfully created.' 
    else
      render :new
    end
  end

  # PATCH/PUT /engagements/1
  # PATCH/PUT /engagements/1.json
  def update
    if @engagement.update(engagement_params)
      redirect_to @app, notice: 'Engagement was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /engagements/1
  # DELETE /engagements/1.json
  def destroy
    @engagement.destroy
    redirect_to @app, notice: 'Engagement was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_engagement
    @engagement = Engagement.find(params[:id])
  end

  def set_app
    @app = App.find(params[:app_id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def engagement_params
    params.require(:engagement).
      permit(:coach_id, :coaching_org_id, :contact_id, :app_id, :team_number,
      :start_date, :screencast_url, :poster_preview_url, :poster_url,
      :presentation_url, :prototype_deployment_url, :student_names, 
      :repository_url, :user_ids => [])
  end
end
