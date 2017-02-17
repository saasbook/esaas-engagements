class Engagement < ActiveRecord::Base
  belongs_to :app
  default_scope { order :start_date => :desc }
end
