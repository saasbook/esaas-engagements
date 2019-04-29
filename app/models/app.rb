class App < ActiveRecord::Base
  belongs_to :org

  has_many :comments, dependent: :destroy, as: :commentable
  has_many :engagements, dependent: :destroy
  has_many :iterations, :through => :engagements

  validates_presence_of :name, :description, :org_id, :status
  validates_presence_of :repository_url, :unless => :pending?

  enum status: [:dead, :development, :in_use, :in_use_and_wants_improvement, :inactive_but_wants_improvement, :pending]
  enum comment_type: [:contact_status, :app_functionality, :general]

  default_scope { order(:name => :asc) }
  scope :featured, -> { where.not("status = ? or status = ?", App.statuses[:dead], App.statuses[:pending]) }

  def as_json(options={})
    options[:only] = [:id,:name,:description,:deployment_url,:repository_url,:most_recent_screencast_url,:most_recent_screenshot_url]
    options[:include] = {:org => { :only => [:name,:url] }}
    super(options)
  end

  def most_recent_screencast_url
    engagements.map(&:screencast_url).reject(&:blank?).first.to_s
  end
  def most_recent_screenshot_url
    engagements.map(&:screenshot_url).reject(&:blank?).first.to_s
  end
  
  def pending?
    status == "pending"
  end

end
