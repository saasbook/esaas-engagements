class Matching < ActiveRecord::Base
  @@preferences = {}
  @@teams = {}
  @@result = {}
  @@projects = []

  @@projects =[1, 2, 3, 4, 5, 6, 7, 8]
  @@preferences = { 'sp21-1' => [1, 2, 3, 4, 5, 6, 7, 8], 'sp21-2' => [3, 2, 4, 1, 5, 7, 8, 6],
                  'sp21-3' => [2, 3, 4, 5, 1, 8, 7, 6], 'sp21-4' => [1, 2, 3, 4, 5, 6, 7, 8],
                  'sp21-5' => [5, 3, 2, 4, 6, 7, 8, 1], 'sp21-6' => [8, 7, 6, 5, 4, 3, 2, 1] }
  @@teams = { 'sp21-1' => [1, 2, 3, 4, 5, 6, 7, 8], 'sp21-2' => [3, 2, 4, 1, 5, 7, 8, 6],
                  'sp21-3' => [2, 3, 4, 5, 1, 8, 7, 6], 'sp21-4' => [1, 2, 3, 4, 5, 6, 7, 8],
                  'sp21-5' => [5, 3, 2, 4, 6, 7, 8, 1], 'sp21-6' => [8, 7, 6, 5, 4, 3, 2, 1] }
  # Global variables to be used across functions for convenience.
  $engagements = @@teams.keys
  $engagement_preferences = @@preferences
  $apps = @@projects
  $app_preferences = {}
  $matchings = {}

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

    # Check if any matchings are unstable
    def rogue_couple_exists
    end

    # Engagment proposes to app. Update matching if app prefers new one more.
    # Return true for successful match, false otherwise.
    def propose(app, engagement)
      puts "Proposing: Team " + engagement + " to " + "App " + app
      # if app already has matching
      if $matchings.key? app
        # compare rank of current match to new proposal
        @previous_match = $matchings[app]
        puts "Previous match: Team " + @previous_match
        @app_preference = $app_preferences[app]
        puts "App Preferences: Teams " + @app_preference.to_s
        @rank_previous = @app_preference.index(@previous_match)
        puts "Rank of previous match: " + @rank_previous.to_s
        @rank_proposal = @app_preference.index(engagement)
        puts "Rank of proposing: " + @rank_proposal.to_s
        puts ""
        # lower number is more preferred because earlier in the preference list
        if @rank_proposal < @rank_previous
          # update new match
          $matchings[app] = engagement
          puts "Matched: " + app + " to " + engagement
          puts ""
          # old match must propose again starting from next highest preference
          @engagement_preference = $engagement_preferences[@previous_match]
          @engagement_preference.each do |app_to_propose|
            @index_curr_app = @engagement_preference.index(app)
            @index_propose_app = @engagement_preference.index(app_to_propose)
            if @index_propose_app > @index_curr_app
              if propose(app_to_propose, @previous_match)
                puts "Previous team: " + @previous_match + "matched with app: " + app_to_propose
                break
              end
            end
          end
          return true
        end

        return false
      else
        # no current match exists for app  -> automatic match
        $matchings[app] = engagement
        puts "Matched: " + app + " to " + engagement
        puts ""
        return true
      end

    end

    # Match using Gale-Shapley
    def match
      if not $matchings.empty?
        return $matchings
      end

      $apps = convert_array_numbers_to_string($apps)

      @engagement_preferences_formatted = {}
      $engagement_preferences.each do |key, value|
        value = convert_array_numbers_to_string(value)
        @engagement_preferences_formatted[key] = value
      end
      $engagement_preferences =@engagement_preferences_formatted

      assign_apps_preferences

      $engagements.each do |e|
        puts "Team Preferences for team " + e + ": "
        puts $engagement_preferences[e].to_s
        puts ""
        $engagement_preferences[e].each do |app|
          if propose(app, e)
            # matched, no need to propose again for now
            break
          end
        end
      end
      puts $matchings
      return $matchings
    end
end
