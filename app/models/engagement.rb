class Engagement < ActiveRecord::Base
  belongs_to :app
  default_scope { order :created_at => :desc }
end
