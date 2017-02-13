class Engagement < ActiveRecord::Base
  belongs_to :organization
  belongs_to :app
end
