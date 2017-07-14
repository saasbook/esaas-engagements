class Engagement < ActiveRecord::Base
  belongs_to :app
  validates_presence_of :app_id

  belongs_to :coaching_org, :class_name => 'Org'
  validates_presence_of :coaching_org_id
  validates_associated :coaching_org
  
  belongs_to :coach, :class_name => 'User'
  validates_presence_of :coach_id
  validates_associated :coach

  belongs_to :contact, :class_name => 'User'

  validates_presence_of :team_number
  validates_presence_of :start_date
  validates_presence_of :student_names
  
  default_scope { order('start_date DESC') }
end
