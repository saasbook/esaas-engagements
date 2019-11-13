class AppEditRequest < ActiveRecord::Base
  belongs_to :app
  belongs_to :approver, class_name: 'User'
  belongs_to :requester, class_name: 'User'

  # Submitted   - When the client submits but no coach has approved
  # Reviewed    - Once the coach gives feedback but has not accepted the changes. Client needs to resubmit.
  # Resubmitted - Once the client has iterated on the coach's feedback and re-submits.
  # Approved    - Coach has accepted the changes and effectively published to Apps.
  enum status: [:submitted, :reviewed, :resubmitted, :approved]

   validate :at_least_one_filled
   validate :one_open_reqeust_per_app
   validates_presence_of :app_id, :requester_id, :status
   
   def at_least_one_filled
    errors.add(:base, 'at least one of description or features should be filled') if
       description.to_s.strip.empty? && features.to_s.strip.empty?
   end

   def one_open_reqeust_per_app
      errors.add(:base, 'only one open edit request allowed per app') unless
      AppEditRequest.where("app_id = ? AND status != ?", app_id, :approved).count == 0
   end

   
end