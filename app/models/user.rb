class User < ActiveRecord::Base
  belongs_to :coaching_org, class_name: 'Org'
  belongs_to :developing_engagement, class_name: 'Engagement'

  has_many :posted_comments, foreign_key: 'user_id', dependent: :destroy
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :client_orgs, class_name: 'Org', foreign_key: :contact_id
  has_many :coaching_engagements, class_name: 'Engagement', foreign_key: :coach_id
  has_many :apps, through: :client_orgs
  has_many :client_engagements, through: :apps, source: :engagements

  has_attached_file :profile_picture, styles: {
  	thumb: '100x100#',
  	medium: '300x300#'
  }, default_url: 'missing_:style.png'

  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :profile_picture, less_than: 5.megabytes

  after_validation :cleanup_paperclip_errors

  enum user_type: [:student, :coach, :client]
  enum comment_type: []

  default_scope { order('name') }

  def participating_engagements
    case
    when student?
      [*developing_engagement]
    when client?
      client_engagements
    when coach?
      coaching_engagements
    else
      []
    end
  end

  private
  def cleanup_paperclip_errors
  	errors.delete(:profile_picture)
  end
end