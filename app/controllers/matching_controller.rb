class MatchingController < ApplicationController
  # redirects students to their engagement's preference page
  # only if they are involved in a matching in progress
  before_action :auth_matching, except: [:show, :store]

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
    @num_engagements = params[:num_engagements].to_i
    if @num_engagements <= 0
      redirect_to '/matching', alert: 'Number of engagements needs to be at least one.'
      return
    end
    @matching = Matching.new
    @matching.engagements.build
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
      redirect_to '/matching/new', alert: 'Invalid matching fields.'
    end
  end

  def show
    @matching = Matching.find(params[:matching_id])
    @engagement = Engagement.find(params[:engagement_id])
    if current_user&.client? or (current_user&.student? and @engagement.developers.where(id: session[:user_id]).empty?)
      redirect_to '/', alert: 'You do not have access to that page.'
      return
    end

    # update current preference
    @currentPreference = []
    @description = {}
    @matching.preferences.each do |key, preference|
      if (key == @engagement.team_number)
        preference.each do |project_id|
          currApp = App.find_by_id(project_id)
          @currentPreference.push(currApp.name)
          @description.store(currApp.name, currApp.description)
        end
      end
    end
  end

  def progress
    @matching = Matching.find(params[:matching_id])
    @engagements = @matching.engagements.order(:team_number).all
    @current_projects = []
    @matching.projects.each do |p|
      @current_projects.push(App.find(p).name)
    end
    @students = {}
    @engagements.each do |e|
      @students[e] = []
      e.developers.each do |d|
        @students[e].push(d.name)
      end
    end
    last_edit_users = @matching.last_edit_users
    matching_status = @matching.status
    @enable_matching = Matching.ready_to_match?(last_edit_users, matching_status)
    @matching_completed = ''
    if matching_status == 'Completed'
      @matching_completed = '(Completed)'
    end
    # for potential new engagement
    @new_engagement = Engagement.new
  end

  def result
    @matching = Matching.find(params[:matching_id])
    if @matching.projects.length < @matching.engagements.count
      redirect_to matching_progress_path(params[:matching_id]), alert: 'Cannot match when you have more engagements than projects.'
      return
    end
    if !Matching.ready_to_match?(@matching.last_edit_users, @matching.status)
      redirect_to matching_progress_path(params[:matching_id]), alert: 'The matching is not ready or is completed.'
      return
    end
    @matching.prepare_match
    @matching.update(result: @matching.match)
    @result = @matching.result

    @engagements = @matching.engagements.order(:team_number).all
    @students = {}
    @engagements.each do |e|
      @students[e] = []
      e.developers.each do |d|
        @students[e].push(d.name)
      end
    end
  end

  def final_edit
    @matching = Matching.find(params[:matching_id])
    if !Matching.ready_to_match?(@matching.last_edit_users, @matching.status)
      redirect_to '/matching', alert: 'The matching is not ready or is completed.'
      return
    end
    @matching.final_edit(params[:final_result])
    redirect_to '/matching'
  end

  def finalize
    @matching = Matching.find(params[:matching_id])
    if !Matching.ready_to_match?(@matching.last_edit_users, @matching.status)
      redirect_to '/matching', alert: 'The matching is not ready or is completed.'
      return
    end
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

    redirect_to show_engagement_matching_path(params[:matching_id], params[:engagement_id])
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

  def update_engagement
    @matching = Matching.find(params[:matching_id])
    if @matching.status == 'Completed'
      redirect_to matching_progress_path(params[:matching_id]), alert: 'Matching is already completed.'
      return
    end
    @engagement = Engagement.find(params[:engagement_id])
    @engagement.update(engagement_params)
    @matching.reset_last_edit_user(@engagement)
    redirect_to matching_progress_path(params[:matching_id]), notice: 'Engagement updated.'
  end

  def delete_engagement
    @matching = Matching.find(params[:matching_id])
    if @matching.status == 'Completed'
      redirect_to matching_progress_path(params[:matching_id]), alert: 'Matching is already completed.'
      return
    end
    @engagement = Engagement.find(params[:engagement_id])
    @matching.remove_engagement(@engagement)
    redirect_to matching_progress_path(params[:matching_id]), notice: 'Engagement deleted.'
  end

  def create_engagement
    @matching = Matching.find(params[:matching_id])
    if @matching.status == 'Completed'
      redirect_to matching_progress_path(params[:matching_id]), alert: 'Matching is already completed.'
      return
    end
    if @matching.projects.length < @matching.engagements.count + 1
      redirect_to matching_progress_path(params[:matching_id]), alert: 'You cannot add more engagements than projects.'
      return
    end
    @engagement = Engagement.new(engagement_params)
    @matching.add_engagement(@engagement)
    redirect_to matching_progress_path(params[:matching_id]), notice: 'Engagement added.'
  end

  def update_apps
    @matching = Matching.find(params[:matching_id])
    if @matching.status == 'Completed'
      redirect_to matching_progress_path(params[:matching_id]), alert: 'Matching is already completed.'
      return
    end
    new_projects = matching_params[:projects]
    new_projects.shift
    if new_projects.length < @matching.engagements.count
      redirect_to matching_progress_path(params[:matching_id]), alert: 'Number of projects cannot be fewer than engagements.'
      return
    end
    @matching.update_projects(new_projects)
    redirect_to matching_progress_path(params[:matching_id]), notice: 'Projects updated.'
  end

  def matching_params
    params.require(:matching).permit(:name, projects: [],
      engagements_attributes: [:coach_id, :team_number, :start_date, :student_names, developer_ids: []])
  end

  def engagement_params
    params.require(:engagement).permit(:coach_id, :team_number, :start_date, :student_names, developer_ids: [])
  end

end
