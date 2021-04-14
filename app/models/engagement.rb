class Engagement < ActiveRecord::Base
  belongs_to :app
  belongs_to :coach, class_name: 'User'
  belongs_to :matching

  has_one :coaching_org, through: :coach
  has_one :client_org, through: :app, source: :org
  has_one :client, through: :client_org, source: :contact

  has_many :iterations, dependent: :destroy
  has_many :developers, foreign_key: :developing_engagement_id, class_name: 'User'

  validates_presence_of :coach_id, :team_number, :start_date
  #:app_id,
  default_scope { order('start_date DESC') }

  def summarize_customer_rating
    customer_ratings = iterations.each.map{|iter| iter.customer_rating}
    valid_count = customer_ratings.count {|rating| !rating.empty?}
    customer_ratings.inject(iterations.create_base_rating_hash) do |cum, cur|
      cum.merge(cur) {|_key, oldValue, newValue| oldValue + newValue / valid_count.to_f}
    end
  end

  def get_semester
    # For simplicity, chose (1/1-5/15) as spring sem, (5/16-8/15) as summer sem, (8/16-12/31) as fall sem
    sp_end = DateTime.new(start_date.year, 5, 16)
    su_end = DateTime.new(start_date.year, 8, 16)

    if start_date < sp_end
      sem = "SP"
    elsif start_date < su_end
      sem = "SU"
    else
      sem = "FA"
    end
    start_date.strftime("#{sem}%y")
  end
end
