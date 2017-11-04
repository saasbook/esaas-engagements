class User < ActiveRecord::Base

  default_scope { order('name') }

  validates_presence_of :name
  validates_presence_of :email
  
  validates :email, uniqueness: true

end