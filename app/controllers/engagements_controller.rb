require 'csv'
require 'json'

class EngagementsController < ApplicationController
  before_action :set_app
  before_action :set_engagement, only: [:edit, :update, :destroy, :export]

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

  def export
    # engagement.iterations returns list of iterations
    # create a hash of iterations
    iterations_hash = Hash.new
    @engagement.iterations.each do |i|
      iterations_hash[i.id] = i.as_json
    end

    # turn engagement into a hash first before adding more stuff to it
    eng_hash = @engagement.as_json
    eng_hash["iterations"] = iterations_hash
    # make entire thing into a json
    eng_params = JSON.parse(eng_hash.to_json)
    keys = eng_params.keys
    values = eng_params.values
    file = CSV.generate do |csv|
      csv << keys
      csv << values
    end
    send_data(file, :filename => "engagement.csv")
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
