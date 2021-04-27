class MatchingController < ApplicationController

  def index
    @matchings = Matching.all
    @currentPreference = nil
    if current_user&.coach?
      render 'index'
    else
      render 'show'
    end
  end

  # GET /matching/new
  def new
    @matching = Matching.new
    @matching.engagements.build
    @num_engagements = params[:num_engagements].to_i
  end

  # POST /matching/create
  def create
    @matching = Matching.new(matching_params)
    if @matching.save
      @matching.projects.shift
      @matching.update(result: Matching.initialize_hash(@matching.engagements))
      @matching.update(last_edit_users: Matching.initialize_hash(@matching.engagements))
      @matching.update(preferences: Matching.initialize_preferences(@matching.engagements, @matching.projects))
      redirect_to '/matching', notice: 'Matching was successfully created.'
    else
      redirect_to '/matching', notice: 'Invalid matching fields.'
    end
  end

  def show
    @matching = Matching.find(params[:matching_id])
    @mockProjectsHash = {
                        "AFX Dance": "Create a website that allows admins of different levels in AFX Dance to organize their audition process and pick dancers.",
                        "BCal API Integration": "Unified portal for event requests and calendar management after transition from Oracle Calendar.",
                        "CS61 series Lab assistant check-in": "Sign in portal for the 61 series lab assistants"
                        }
    @currentPreference = ["AFX Dance", "BCal API Integration", "CS61 series Lab assistant check-in"]
    # Matching.find_or_create_by(:id => 1).preferences
  end

  def progress
    @matching = Matching.find(params[:matching_id])
    @engagements = @matching.engagements.order(:team_number).all
    @students = {}
    @engagements.each do |e|
      @students[e] = []
      e.developers.each do |d|
        @students[e].push(d.name)
      end
    end
  end

  def result
    @matching = Matching.find(params[:matching_id])
    @matching.prepare_match
    @matching.update(result: @matching.match)
    @result = @matching.result
  end

  def finalize
    @matching = Matching.find(params[:matching_id])
    @matching.finalize
    redirect_to '/matching', notice: 'Matching was successfully finalized.'
  end

  def store
    @match = Matching.find_or_create_by(:id => 1)
    preference = params[:preferences]
    @match.update_attributes(:preferences => preference)
  end

  def destroy
    @matching = Matching.find(params[:matching_id])
    if @matching.status != "Completed"
      @matching.engagements.each do |e|
        e.destroy
      end
      @matching.destroy
    else
      @matching.destroy
    end
    redirect_to '/matching', notice: 'Matching deleted.'
  end

  # GET /matching/edit
  def edit
    @matching = Matching.find(params[:matching_id])
  end

  # PATCH/PUT /matching/update
  def update
    @matching = Matching.find(params[:matching_id])
    @matching.update(matching_params)
    redirect_to '/matching', notice: 'Matching updated.'
  end

  def matching_params
    params.require(:matching).permit(:name, projects: [],
      engagements_attributes: [:coach_id, :team_number, :start_date, :student_names, developer_ids: []])
  end
end
