class App < ActiveRecord::Base
  belongs_to :org

  has_many :comments, dependent: :destroy, as: :commentable
  has_many :engagements, dependent: :destroy
  has_many :iterations, :through => :engagements
  has_many :app_edit_requests, dependent: :destroy

  validates_presence_of :name, :description, :org_id, :status
  validates_presence_of :repository_url, unless: :repoUrlOptional?
  #TODO: validates_presence_of pivotal_tracker_url

  enum status: [:dead, :development, :in_use, :in_use_and_wants_improvement, :inactive_but_wants_improvement, 
                :pending, :vetting_pending, :on_hold, :staff_approved, :customer_informed, 
                :customer_confirmation_received, :declined_by_staff,  :declined_by_customer, :declined_by_customer_available_next_sem, :back_up]
  
  
  @@STATUS_ORDERS = [1, 6, 7, 8, 9, 10, 11, 12, 13, 14, 2, 3, 4, 5, 0]
  
  
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

  def self.for_orgs(orgs, limit=10, offset=0)
    App.unscoped.where(:org_id => orgs).limit(limit).offset(offset).sort_by_status
  end

  def self.status_count_for_orgs(orgs=nil)
    if orgs == nil
      App.group(:status).reorder(:status).count
    else
      App.where(:org_id => orgs).group(:status).reorder(:status).count
    end
  end

  def self.sort_by_status
      order_by = ['CASE']
      @@STATUS_ORDERS.each_with_index do |rank, index|
        order_by << "WHEN status=#{rank} THEN #{index}"
      end
      order_by << 'END ASC, id ASC'
      App.order(order_by.join(' '))
  end

  def self.belongs_to_user(app_id, contact_id)
    orgs = Org.for_user(contact_id)
    App.where(org_id: orgs).where(id: app_id).count != 0
  end
end

