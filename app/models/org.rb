class Org < ActiveRecord::Base
  has_many :apps, :foreign_key => 'org_id'
  belongs_to :contact, :class_name => 'User'

  validates :name, :presence => true
  validates :name, uniqueness: true

  default_scope { order :name => :asc }
end
