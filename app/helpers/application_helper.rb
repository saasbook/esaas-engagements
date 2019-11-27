module ApplicationHelper
  def form_errors_for(object=nil)
    render 'shared/form_errors', object: object unless object.blank?
  end

  def self.get_edit_request_for(current_user_id, app_id)
    return nil if current_user_id.nil? || app_id.nil?
    return nil unless App.belongs_to_user(app_id, current_user_id)
    AppEditRequest.get_request_for(app_id)
  end

  def self.get_edit_req_banner_class(app_edit_request)
    banner_class_by_status = {
        submitted:   '-success',
        reviewed:    '-danger',
        resubmitted: '-warning'
    }
    banner_class_by_status[app_edit_request&.status&.to_sym] || '-info'
  end

  def self.get_edit_req_banner_message(app_edit_request)
    banner_message_by_status = {
        submitted:   'Your app edit request has been submitted to staff for review and approval. Staff has not yet reviewed/approved this request.',
        reviewed:    'Staff has reviewed and left feedback on your edit request. Kindly review staff feedback and update the request.',
        resubmitted: 'You resubmitted an edit request after staff left feedback but staff has not yet reviewed your updates.'
    }
    banner_message_by_status[app_edit_request&.status&.to_sym] || 'There are currently no edit requests for your app. You can request new edits for you app here.'
  end

  def self.get_date_format
    '%B %d, at %l:%m %p %Y'
  end

  def self.edit_request_button_text(app)
      request = AppEditRequest.where(app_id: app.id).first
      return "Update Request" unless request.nil?
      return "Request New Feature" if request.nil? && app.status.to_s == "dead"
      "Request Change"
  end
end
