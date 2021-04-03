class Matching < ActiveRecord::Base
    serialize :preferences, Hash
    serialize :teams, Hash
    serialize :result, Hash
    serialize :projects, Array
end
