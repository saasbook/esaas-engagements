class Org < ActiveRecord::Base
  has_many :apps

  validates :name, :presence => true
  #validates :url, :contact_name, :contact_email, :presence => true

  default_scope { order :name => :asc }
end
