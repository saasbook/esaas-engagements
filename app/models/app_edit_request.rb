class AppEditRequest < ActiveRecord::Base
  self.primary_key = :app_id
  belongs_to :app, foreign_key: :app_id
  belongs_to :approver, class_name: 'User'
  belongs_to :requester, class_name: 'User'

  # Submitted   - When the client submits but no coach has approved
  # Reviewed    - Once the coach gives feedback but has not accepted the changes. Client needs to resubmit.
  # Resubmitted - Once the client has iterated on the coach's feedback and re-submits.
  enum status: [:submitted, :reviewed, :resubmitted]

  # Note: if either description.blank? or features.blank? then it is assumed that the user does not
  # want edits for the blank field. Hence we don't display blank fields as an edit for the coach.

  scope :featured, -> { order(:status, :created_at) }

  validate :at_least_one_filled
  validate :one_open_request_per_app, on: :create
  validate :at_least_one_change_was_made
  validates_presence_of :app_id, :requester_id, :status

  def at_least_one_change_was_made
    errors.add(:base, 'Cannot submit a form with no changes made.') if
        (features == App.find(app_id)&.features) && (description == App.find(app_id)&.description)
  end

  def at_least_one_filled
   errors.add(:base, 'At least one of description or features should be filled.') if
      (description.to_s.strip.empty?) && (features.to_s.strip.empty?)
  end

  def one_open_request_per_app
      unless AppEditRequest.get_request_for(app_id).nil?
        errors.add(:base, 'There is another one edit request for this app. Only one open edit request is allowed per app.')
    end
  end

  def self.get_request_for(app_id)
    AppEditRequest.where(app_id: app_id).first
  end
end
