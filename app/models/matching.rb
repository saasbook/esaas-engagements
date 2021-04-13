class Matching < ActiveRecord::Base
  @@preferences = {}
  @@teams = {}
  @@result = {}
  @@projects = []

  # Dummy data for testing in ruby console. Uncomment and run commands: m = Matching.create and m.match to see results
  # @@projects =[1, 2, 3, 4, 5, 6, 7, 8]
  # @@preferences = { 'sp21-1' => [1, 2, 3, 4, 5, 6, 7, 8], 'sp21-2' => [3, 2, 4, 1, 5, 7, 8, 6],
                #  'sp21-3' => [2, 3, 4, 5, 1, 8, 7, 6], 'sp21-4' => [1, 2, 3, 4, 5, 6, 7, 8],
                #  'sp21-5' => [5, 3, 2, 4, 6, 7, 8, 1], 'sp21-6' => [8, 7, 6, 5, 4, 3, 2, 1] }
  # @@teams = { 'sp21-1' => [1, 2, 3, 4, 5, 6, 7, 8], 'sp21-2' => [3, 2, 4, 1, 5, 7, 8, 6],
                #  'sp21-3' => [2, 3, 4, 5, 1, 8, 7, 6], 'sp21-4' => [1, 2, 3, 4, 5, 6, 7, 8],
                #  'sp21-5' => [5, 3, 2, 4, 6, 7, 8, 1], 'sp21-6' => [8, 7, 6, 5, 4, 3, 2, 1] }

  # Global variables to be used across functions for convenience.
  $engagements = @@teams.keys
  $engagement_preferences = @@preferences
  $apps = @@projects
  $app_preferences = {}
  $matchings = {}

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
      $engagement_preferences =@engagement_preferences_formatted

      assign_apps_preferences

      # Each team will propose to the next preferred project (app).
      $engagements.each do |team|
          propose(team, $engagement_preferences[team])
      end

      puts $matchings
      return $matchings
    end
end
