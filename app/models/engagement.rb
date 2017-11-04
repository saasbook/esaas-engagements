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

  has_many :iterations

  default_scope { order('start_date DESC') }

  def summarize_customer_rating
    customer_ratings = iterations.each.map{|iter| iter.customer_rating}
    valid_count = customer_ratings.count {|rating| !rating.empty?}
    stat_avg = customer_ratings.inject(iterations.create_base_rating_hash) do |cum, cur|
      cum.merge(cur) {|key, oldValue, newValue| oldValue + newValue / valid_count.to_f}
    end
  end
end
