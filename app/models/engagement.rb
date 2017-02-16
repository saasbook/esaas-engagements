class Engagement < ActiveRecord::Base
  belongs_to :org
  belongs_to :app
end
