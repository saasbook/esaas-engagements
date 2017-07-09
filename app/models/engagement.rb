class Engagement < ActiveRecord::Base
  belongs_to :app
  belongs_to :coaching_org, :class_name => 'Org'
  belongs_to :coach, :class_name => 'User'
  belongs_to :contact, :class_name => 'User'
  
  default_scope { order :start_date => :desc }
end
