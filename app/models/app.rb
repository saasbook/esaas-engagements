class App < ActiveRecord::Base
  belongs_to :org
  has_many :engagements

  validates_presence_of :name, :description, :org_id, :status, :repository_url
  

  default_scope { order(:name => :asc) }
  enum :status => { :dead => 0, :development => 1, :in_use => 2, :in_use_and_wants_improvement => 3, :inactive_but_wants_improvement => 4 }

end
