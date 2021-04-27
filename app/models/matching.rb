class Matching < ActiveRecord::Base
    has_many :engagements
    serialize :projects, Array
    serialize :preferences, Hash
    serialize :result, Hash
    serialize :last_edit_users, Hash

    @@STATUSES = ['Collecting responses', 'Responses collected', 'Completed']

    validates_presence_of :name, :projects
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
          self.status = 'Responses collected'
        end
      end
    end

    # Assign current result projects to corresponding engagements
    def finalize
      self.engagements.each do |e|
        project_id = self.result[e.team_number]
        e.update(app_id: project_id)
      end
      self.status = 'Completed'
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
