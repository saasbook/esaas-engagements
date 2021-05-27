class Matching < ActiveRecord::Base
    has_many :engagements
    serialize :projects, Array
    serialize :preferences, Hash
    serialize :result, Hash
    serialize :last_edit_users, Hash

    @@STATUSES = ['Collecting responses', 'Responses collected', 'Completed']

    validates_presence_of :name, :projects, message: 'must present in a matching.'
    validates_uniqueness_of :name, message: 'must be unique.'
    validates_inclusion_of :status, in: @@STATUSES
    accepts_nested_attributes_for :engagements

    def self.initialize_hash(engagements)
      h = {}
      engagements.each do |e|
        h.store(e.team_number, 0)
      end
      h
    end

    def self.initialize_preferences(engagements, projects)
      h = {}
      engagements.each do |e|
        h.store(e.team_number, projects)
      end
      h
    end

    # return individual engagement status
    def self.engagement_status(last_edit_user)
      if last_edit_user == 0
        return 'Not responded yet'
      else
        return 'Responded'
      end
    end

    # update matching status
    def update_status
      if self.status == 'Collecting responses'
        if !self.last_edit_users.has_value?(0)
          self.update(status: 'Responses collected')
        end
      end
    end

    # coach can do a final edit of the matching result
    def final_edit(final_result)
      h = self.result
      h.keys.each_with_index do |key, index|
        h.store(key, App.find_by_name(final_result[index]).id)
      end
      self.update(result: h)
    end

    # assign current result projects to corresponding engagements
    def finalize
      self.engagements.each do |e|
        project_id = self.result[e.team_number]
        e.update(app_id: project_id)
      end
      self.update(status: 'Completed')
    end

    def self.calculate_respond_percentage(last_edit_users)
      responded = 0
      last_edit_users.each do |team, last_edit_user|
        if last_edit_user != 0
          responded += 1
        end
      end
      return responded.to_f / last_edit_users.length.to_f * 100
    end

    def self.ready_to_match?(last_edit_users, matching_status)
      (self.calculate_respond_percentage(last_edit_users) == 100 and matching_status != 'Completed')
    end

    def self.find_last_edit_user(matching, engagement)
      matching.last_edit_users.each do |team, last_edit_user_id|
        if (team == engagement.team_number)
          if (last_edit_user_id == 0)
            return "Your team has not responded yet!"
          else
            return "Last updated by " + User.find(last_edit_user_id).name + " at " + matching.updated_at.strftime("%B %d, %Y")
          end
        end
      end
      raise "Database has wrong info for matching!"
    end

    # returns the engagement id the user is developing if its in an active matching
    # returns 0 if such id does not exist
    def self.find_user_engagement_id(user_id)
      dev_engagement = User.find(user_id).developing_engagement
      if !dev_engagement.nil?
        matching = dev_engagement.matching
        if !matching.nil?
          if matching.status != 'Completed'
            return dev_engagement.id
          end
        end
      end
      return 0
    end

    # update related values from all hash fields when an engagement is updated
    def update_engagement(engagement, old_team_number)
      team_number = engagement.team_number
      new_last_edit_users = self.last_edit_users
      new_preferences = self.preferences
      new_result = self.result
      new_last_edit_users.delete(old_team_number)
      new_last_edit_users.store(team_number, 0)
      new_preferences[team_number] = new_preferences.delete old_team_number
      new_result[team_number] = new_result.delete old_team_number
      self.update(last_edit_users: new_last_edit_users)
      self.update(preferences: new_preferences)
      self.update(result: new_result)
    end

    # remove related values from all hash fields when an engagement is deleted
    # destroy the engagement afterward
    def remove_engagement(engagement)
      team_number = engagement.team_number
      new_last_edit_users = self.last_edit_users
      new_preferences = self.preferences
      new_result = self.result
      new_last_edit_users.delete(team_number)
      new_preferences.delete(team_number)
      new_result.delete(team_number)
      self.update(last_edit_users: new_last_edit_users)
      self.update(preferences: new_preferences)
      self.update(result: new_result)
      engagement.destroy
    end

    # add an engagement to the current matching
    def add_engagement(engagement)
      team_number = engagement.team_number
      new_last_edit_users = self.last_edit_users
      new_preferences = self.preferences
      new_result = self.result
      new_last_edit_users.store(team_number, 0)
      new_preferences.store(team_number, self.projects)
      new_result.store(team_number, 0)
      self.update(last_edit_users: new_last_edit_users)
      self.update(preferences: new_preferences)
      self.update(result: new_result)
    end

    # update project pool of the current matching
    # reset all fields
    def update_projects(projects)
      new_last_edit_users = self.last_edit_users
      new_preferences = self.preferences
      new_result = self.result
      new_last_edit_users.each do |k, v|
        new_last_edit_users.store(k, 0)
      end
      new_preferences.each do |k, v|
        new_preferences.store(k, projects)
      end
      new_result.each do |k, v|
        new_result.store(k, 0)
      end
      self.update(last_edit_users: new_last_edit_users)
      self.update(preferences: new_preferences)
      self.update(result: new_result)
      self.update(projects: projects)
    end

    # Global variables to be used across functions for convenience.
    def prepare_match
      $engagements = self.preferences.keys
      $engagement_preferences = self.preferences
      $apps = self.projects
      $app_preferences = {}
      $matchings = {}
    end

    # Indexing and looking up projects (represented by ints) is confusing. Represent ints in arrays as strings.
    def convert_array_numbers_to_string(arr)
      return arr.map(&:to_s)
    end

    # The matching algorithm uses Gale-Shapley which requires a preference list
    def assign_apps_preferences
      if $app_preferences.empty?
        $apps.each do |curr_app|
          @randomized_preferences = $engagements.shuffle
          $app_preferences[curr_app] = @randomized_preferences
        end
      end
    end

    # Engagment proposes to apps. Update matching if app prefers new one more.
    # Return true for successful match, false otherwise.
    def propose(team, team_preferences)
      team_preferences.each do |app|
        puts "Team preferences: " + team_preferences.to_s
        puts "Team " + team + " proposing to App " + app
        # Check if the app is currently matched
        if $matchings.key? app
          # compare rank of current match to new proposing team
          @previous_match = $matchings[app]
          puts "Previous match: Team " + @previous_match
          @app_preference = $app_preferences[app]
          puts "App Preferences: Teams " + @app_preference.to_s
          @rank_previous = @app_preference.index(@previous_match)
          puts "Rank of previous match: " + @rank_previous.to_s
          @rank_proposal = @app_preference.index(team)
          puts "Rank of proposing: " + @rank_proposal.to_s
          puts ""

          # lower number is more preferred because earlier in the preference list
          if @rank_proposal < @rank_previous
            # Update match
            $matchings[app] = team
            puts "Matched App " + app + " to Team " + team
            puts ""
            # Old match must propose again starting from next highest preference
            @engagement_preference = $engagement_preferences[@previous_match]
            puts "Previous Matched Team preferences: "
            puts @engagement_preference.to_s
            @index_of_match = @engagement_preference.index(app)

            puts "Previous Team " + @previous_match + " proposing again"
            propose(@previous_match, @engagement_preference.slice(@index_of_match + 1, @engagement_preference.length))
            return true
          end
          puts "App " + app + " prefers current matched Team " + @previous_match + " over proposing Team " + team
          puts ""
        else
          # App has no current match. Set matching to current proposer.
          $matchings[app] = team
          puts "Matched App " + app + " to Team " + team
          puts ""
          return true
        end
      end
    end

    # Match using Gale-Shapley
    def match
      if not $matchings.empty?
        return $matchings
      end

      # Format the projects to be strings instead of ints for indexing/lookup convenience.
      $apps = convert_array_numbers_to_string($apps)

      # Format the team preferences hash to have string values instead of ints representing projects.
      @engagement_preferences_formatted = {}
      $engagement_preferences.each do |key, value|
        value = convert_array_numbers_to_string(value)
        @engagement_preferences_formatted[key] = value
      end
      $engagement_preferences = @engagement_preferences_formatted

      assign_apps_preferences

      # Each team will propose to the next preferred project (app).
      $engagements.each do |team|
          propose(team, $engagement_preferences[team])
      end

      # maps team_number -> app_id instead of app_id -> team_number
      return $matchings.invert
    end
end
