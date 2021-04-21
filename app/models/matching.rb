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

    def self.engagement_status(last_edit_user)
      if last_edit_user == 0
        return 'Not responded yet'
      else
        return 'Responded'
      end
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
