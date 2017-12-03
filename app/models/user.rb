class User < ActiveRecord::Base
  belongs_to :coaching_org, class_name: 'Org'
  belongs_to :developing_engagement, class_name: 'Engagement'

  has_many :comments, foreign_key: 'user_id', dependent: :destroy
  has_many :client_orgs, class_name: 'Org', foreign_key: :contact_id
  has_many :coaching_engagements, class_name: 'Engagement', foreign_key: :coach_id
  has_many :apps, through: :client_orgs
  has_many :client_engagements, through: :apps, source: :engagements

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  enum user_type: [:student, :coach, :client]

  default_scope { order('name') }
end