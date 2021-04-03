class Matching < ActiveRecord::Base
    serialize :preference, Hash
end
