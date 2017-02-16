class App < ActiveRecord::Base
  belongs_to :org
  has_many :engagements

  default_scope { order(:name => :asc) }
  enum :status => { :inactive => 0, :development => 1, :maintenance => 2 }

end
