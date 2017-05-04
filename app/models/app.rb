class App < ActiveRecord::Base
  belongs_to :org
  has_many :engagements

  validates_presence_of :name, :description, :org_id, :status, :repository_url
  

  default_scope { order(:name => :asc) }
  enum :status => { :inactive => 0, :development => 1, :maintenance => 2 }

end
