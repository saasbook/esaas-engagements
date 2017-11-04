class Org < ActiveRecord::Base
  has_many :apps
  belongs_to :contact, :class_name => 'User'

  validates :name, :presence => true
  #validates :url, :contact_name, :contact_email, :presence => true

  validates :name, uniqueness: true

  default_scope { order :name => :asc }
end
