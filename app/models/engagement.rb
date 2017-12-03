class Engagement < ActiveRecord::Base
  belongs_to :app
  belongs_to :coach, class_name: 'User'

  has_one :coaching_org, through: :coach
  has_one :client_org, through: :app, source: :org
  has_one :client, through: :client_org, source: :contact

  has_many :iterations, dependent: :destroy
  has_many :developers, foreign_key: :developing_engagement_id, class_name: 'User'

  validates_presence_of :app_id, :coach_id, :team_number, :start_date

  default_scope { order('start_date DESC') }

  def summarize_customer_rating
    customer_ratings = iterations.each.map{|iter| iter.customer_rating}
    valid_count = customer_ratings.count {|rating| !rating.empty?}
    customer_ratings.inject(iterations.create_base_rating_hash) do |cum, cur|
      cum.merge(cur) {|_key, oldValue, newValue| oldValue + newValue / valid_count.to_f}
    end
  end
end
