class App < ActiveRecord::Base
  belongs_to :org

  has_many :comments, dependent: :destroy, as: :commentable
  has_many :engagements, dependent: :destroy
  has_many :iterations, :through => :engagements

  validates_presence_of :name, :description, :org_id, :status
  validates_presence_of :repository_url, unless: :repoUrlOptional?

  enum status: [:dead, :development, :in_use, :in_use_and_wants_improvement, :inactive_but_wants_improvement, :pending, 
    :vetting_pending, :on_hold, :staff_approved,:customer_informed, :customer_confirmation_received, :declined_by_staff, 
    :declined_by_customer, :declined_by_customer_available_next_sem, :back_up]
  # there should be more efficient ways handling status categorization
  @@VETTING_STATUSES = [:vetting_pending, :on_hold, :staff_approved,:customer_informed, 
    :customer_confirmation_received, :declined_by_staff, :declined_by_customer, :declined_by_customer_available_next_sem, :back_up]
  @@DEPLOYMENT_STATUSES = [:dead, :development, :in_use, :in_use_and_wants_improvement, :inactive_but_wants_improvement, :pending]

  enum comment_type: [:contact_status, :app_functionality, :general, :vetting]

  default_scope { order(:name => :asc) }
  scope :featured, -> { where.not("status = ? or status = ?", App.statuses[:dead], App.statuses[:pending]) }

  def as_json(options={})
    super(options.merge({
          :only => [:id,:name,:description,:deployment_url,:repository_url],
          :methods => [:most_recent_screencast_url,:most_recent_screenshot_url],
          :include => {:org => { :only => [:name,:url] }}
        }))
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

  def self.getAllVettingStatuses
    @@VETTING_STATUSES
  end

  def self.getAllDeploymentStatuses
    @@DEPLOYMENT_STATUSES
  end

  def inVettingStatus?
    @@VETTING_STATUSES.include? status.to_sym
  end

  def inDeploymentStatus?
    @@DEPLOYMENT_STATUSES.include? status.to_sym
  end

  def repoUrlOptional?
    pending? || inVettingStatus?
  end
end
