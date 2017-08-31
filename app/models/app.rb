class App < ActiveRecord::Base
  belongs_to :org
  has_many :engagements
  has_many :iterations, :through => :engagements
  
  validates_presence_of :name, :description, :org_id, :status, :repository_url
  

  default_scope { order(:name => :asc) }
  enum :status => { :dead => 0, :development => 1, :in_use => 2, :in_use_and_wants_improvement => 3, :inactive_but_wants_improvement => 4 }

  scope :featured, -> { where.not(:status => :dead) }

  def as_json(options={})
    options[:only] = [:id,:name,:description,:deployment_url,:repository_url]
    options[:include] = {:org => { :only => [:name,:url] }}
    super(options)
  end

end
