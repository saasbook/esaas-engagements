class Org < ActiveRecord::Base
  has_many :apps, :foreign_key => 'org_id'
  has_many :comments, as: :commentable
  belongs_to :contact, :class_name => 'User'

  validates :name, :presence => true
  validates :name, uniqueness: true

  default_scope { order :name => :asc }

  enum :comment_type => {}

  def address
  	[address_line_1, address_line_2, city_state_zip].join("\n").squish
  end
end
