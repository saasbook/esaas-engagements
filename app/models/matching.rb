class Matching < ActiveRecord::Base
    serialize :preferences, Hash
    serialize :teams, Hash
    serialize :result, Hash
    serialize :projects, Array

    # Mock global variables for testing purposes
    $engagements = ["A", "B", "C", "D"]
    $pref_A = ["Breathe", "CalApps", "Cafe Hub", "AFX"]
    $pref_B = ["Breathe", "Cafe Hub", "AFX", "CalApps"]
    $pref_C = ["AFX", "Breathe", "CalApps", "Cafe Hub"]
    $pref_D = ["CalApps", "Cafe Hub", "AFX", "Breathe"]

    $engagement_preferences = {"A" => $pref_A, "B" => $pref_B, "C" => $pref_C, "D" => $pref_D }

    $apps = ["AFX", "Breathe", "CalApps", "Cafe Hub"]
    $app_preferences = {}

    $matchings = {}

    # The matching algorithm uses Gale-Shapley which requires a preference list
    def self.assign_apps_preferences
      if $app_preferences.empty?
        $apps.each do |curr_app|
          @randomized_preferences = $engagements.shuffle
          $app_preferences[curr_app] = @randomized_preferences
          puts "Current app: "
          puts curr_app
          puts ""
          puts "Randomized Preferences: "
          puts @randomized_preferences
          puts ""
        end
      end
    end

    # Check if any matchings are unstable
    def self.rogue_couple_exists
    end

    # Engagment proposes to app. Update matching if app prefers new one more.
    # Return true for successful match, false otherwise.
    def self.propose(app, engagement)

      # if app already has matching
      if $matchings.key? app
        # compare rank of current match to new proposal
        @previous_match = $matchings[app]
        @app_preference = $app_preferences[app]
        @rank_previous = @app_preference.index(@previous_match)
        @rank_proposal = @app_preference.index(engagement)

        # lower number is more preferred because earlier in the preference list
        if @rank_proposal < @rank_previous
          # update new match
          $matchings[app] = engagement
          puts "Matched: " + engagement + " -> " + app
          puts ""
          # old match must propose again starting from next highest preference
          @engagement_preference = $engagement_preferences[@previous_match]
          @engagement_preference.each do |app_to_propose|
            @index_curr_app = @engagement_preference.index(app)
            @index_propose_app = @engagement_preference.index(app_to_propose)
            if @index_propose_app > @index_curr_app
              if propose(app_to_propose, @previous_match)
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
        puts "Matched: " + engagement + " -> " + app
        puts ""
        return true
      end

    end

    # Match using Gale-Shapley
    def self.output_matchings
      if not $matchings.empty?
        return $matchings
      end

      assign_apps_preferences

      $engagements.each do |e|
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
