class App < ActiveRecord::Base
  belongs_to :org

  has_many :comments, dependent: :destroy, as: :commentable
  has_many :engagements, dependent: :destroy
  has_many :iterations, :through => :engagements

  validates_presence_of :name, :description, :org_id, :status
  validates_presence_of :repository_url, unless: :pending?

  enum status: [:dead, :development, :in_use, :in_use_and_wants_improvement, :inactive_but_wants_improvement, :pending]
  enum vetting_status: [:vetting_pending, :on_hold, :staff_approved,:customer_informed, :customer_confirmation_received, :declined_by_staff, :declined_by_customer, :declined_by_customer_available_next_sem, :back_up]
  enum comment_type: [:contact_status, :app_functionality, :general]

  default_scope { order(:name => :asc) }
  scope :featured, -> { where.not("status = ? or status = ?", App.statuses[:dead], App.statuses[:pending]) }

  def as_json(options={})
    options[:only] = [:id,:name,:description,:deployment_url,:repository_url]
    options[:include] = {:org => { :only => [:name,:url] }}
    super(options)
  end

  def pending?
    status == "pending"
  end

end
