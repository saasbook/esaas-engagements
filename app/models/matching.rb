class Matching < ActiveRecord::Base
    serialize :preferences, Hash
    serialize :teams, Hash
    serialize :result, Hash
    serialize :projects, Array

    validates_presence_of :name, :teams, :projects

    # given :preferences exist, produces a matching between team_number and app_id, stores in :result
    def match
      # :preferences format:
      # each team_number maps to an array of app_id's.
      # position in array indicates ranking (position 0 is the most preferred project)
      # number of keys is the number of teams participating
      # num projects >= num teams
      # example:
      preferences = { "sp21-1" => [ "app_id1", "app_id2", "app_id3" ], "sp21-2" => [ "app_id3", "app_id2", "app_id1" ] }

      # :result format:
      # each team_number maps to one app_id
      # match function updates the :result after running its matching algorithm
      # example:
      result = { "sp21-1" => "app_id1", "sp21-2" => "app_id3" }
    end
end
