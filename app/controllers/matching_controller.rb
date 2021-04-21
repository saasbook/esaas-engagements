class MatchingController < ApplicationController

  def index
    @matchings = Matching.all
    @currentPreference = nil
    if current_user&.coach?
      render 'index'
    else
      render 'show'
    end

    # [["Matching 1", "Complete", 1], ["Matching 2", "In Progress", 2], ["Matching 3", "Complete", 3]]

  end

  # GET /matching/new
  def new
    @matching = Matching.new
    @matching.engagements.build
    @num_engagements = params[:num_engagements].to_i
  end

  # POST /matching
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
    @engagement = Engagement.find(params[:engagement_id])

    @currentPreference = []
    @description = []
    @matching.preferences.each do |key, preference| 
      if (key == @engagement.team_number)
        preference.each do |project_id|
          currApp = App.find_by_id(project_id)
          @currentPreference.push(currApp.name)
          @description.push(currApp.description)
        end
      end
    end
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

  def store
    currentPreferences = params[:preference]

    dummy = []
    currentPreferences.each do |currentPreference|
      dummy.push(App.where(:name => currentPreference).first.id.to_s)
    end

    @matching = Matching.find(params[:matching_id])
    @engagement = Engagement.find(params[:engagement_id])

    newPreferences = {}
    @matching.preferences.each do |key, preference| 
      if (@engagement.team_number == key)
        newPreferences[key] = dummy
      else 
        newPreferences[key] = preference
      end
    end
    @matching.update_attributes(:preferences => newPreferences)
  end

  def destroy
    Matching.find(params[:matching_id]).destroy
    redirect_to '/matching', notice: 'Matching deleted.'
  end

  def matching_params
    params.require(:matching).permit(:name, projects: [],
      engagements_attributes: [:coach_id, :team_number, :start_date, :student_names, developer_ids: []])
  end
end
