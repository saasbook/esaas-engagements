class Iteration < ActiveRecord::Base

  belongs_to :engagement
  validates_presence_of :engagement_id
  validates_associated :engagement

  validates_presence_of :end_date
  
  default_scope { order('end_date ASC') }
  
  def parse_customer_feedback
    JSON.parse(customer_feedback)
  end
  
end
