class MatchingController < ApplicationController

  def index
    @matchings = Matching.all
    @matchings.each do |m|
      m.update_status
    end
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
      redirect_to '/matching/new', notice: 'Invalid matching fields.'
    end
  end

  def show
    @matching = Matching.find(params[:matching_id])
    @engagement = Engagement.find(params[:engagement_id])

    # update current preference
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

  def result
    @matching = Matching.find(params[:matching_id])
    @matching.prepare_match
    @matching.update(result: @matching.match)
    @result = @matching.result
  end

  def finalize
    @matching = Matching.find(params[:matching_id])
    @matching.finalize
    redirect_to '/matching', notice: 'Engagements were successfully finalized.'
  end

  def store
    @matching = Matching.find(params[:matching_id])
    @engagement = Engagement.find(params[:engagement_id])

    # Update last update users
    new_last_edit_users = @matching.last_edit_users
    @last_update_id = User.find_by_github_uid(params[:update_by]).id
    @matching.last_edit_users.each do |team, edit_user|
      if (team == @engagement.team_number)
        new_last_edit_users[team] = @last_update_id
      end
    end
    @matching.update_attributes(:last_edit_users => new_last_edit_users)


    if not params[:preference].nil?
      currentPreferences = params[:preference]

      dummy = []
      currentPreferences.each do |currentPreference|
        dummy.push(App.where(:name => currentPreference).first.id.to_s)
      end


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
  end

  def destroy
    @matching = Matching.find(params[:matching_id])
    if @matching.status != 'Completed'
      @matching.engagements.each do |e|
        e.destroy
      end
      @matching.destroy
      redirect_to '/matching', notice: 'Matching deleted.'
    else
      @matching.destroy
      redirect_to '/matching', notice: 'Matching record deleted. (Engagements persist)'
    end
  end

  def matching_params
    params.require(:matching).permit(:name, projects: [],
      engagements_attributes: [:coach_id, :team_number, :start_date, :student_names, developer_ids: []])
  end
end
