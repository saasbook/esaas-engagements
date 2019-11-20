class MyApprovalRequestsController < ApplicationController
  append_after_filter :must_be_coach
  before_action :set_my_approval_request, only: [:show, :update]

  # GET /my_approval_requests
  # GET /my_approval_requests.json
  def index
    @index_form = IndexForm.new(params['my_approvals'] || {}, session['my_approvals'] || default_index_form_params)
    redirect_to my_approval_requests_path(status: @index_form.as_hash) if params['status'].blank? && !@index_form.blank?
    @my_approval_requests = AppEditRequest.where(status: @index_form.get_filter_statuses)
    session['my_approvals'] = @index_form.as_hash
  end

  # GET /my_approval_requests/:app_id
  # GET /my_approval_requests/1
  # GET /my_approval_requests/1.json
  def show
    redirect_to my_approval_requests_path,
                alert: %Q{Could not find an edit request for app with id: #{params[:app_id]}} if @app_edit_request.nil?
  end

  # PATCH/PUT /my_approval_requests/:app_id
  # PATCH/PUT /my_approval_requests/1
  # PATCH/PUT /my_approval_requests/1.json
  def update
    redirect_to show_my_approval_request_path(app_id: @app_edit_request.app_id),
                alert: 'You must provide feedback for request or approve or both.' if params[:feedback].blank? && params[:approve].nil?
    if update_edit_request
      redirect_to my_approval_requests_path, notice: @success_msg
    else
      redirect_to show_my_approval_request_path(app_id: @app_edit_request.app_id),
                  alert: @app_edit_request.errors.full_messages.join(" ") || 'Failed to update request.'
    end
  end

  private
    def update_edit_request
      # Todo: send email. Right now the client never see's feedback if the edits are approved.
      if params[:approve]
        @app.description = (@app_edit_request.description.blank?) ? @app.features : @app_edit_request.description
        @app.features = (@app_edit_request.features.blank?) ? @app.features : @app_edit_request.features
        @success_msg = %Q{You have successfully approved edits for "#{@app_edit_request.app.name}".}
        @app.save && @app_edit_request.destroy
      elsif params[:feedback]
        @app_edit_request.feedback = params[:feedback]
        @app_edit_request.status = :reviewed
        @success_msg = %Q{You have successfully left feedback for "#{@app_edit_request.app.name}".}
        @app_edit_request.save
      end
    end

    def must_be_coach
      redirect_to apps_path, alert: %q{Only staff can access the approval pages} unless current_user&.coach?
    end

    def set_my_approval_request
      @app_edit_request = AppEditRequest.find(params[:app_id])
      @app = @app_edit_request.app
    end

    def default_index_form_params
      %w(submitted_status reviewed_status resubmitted_status).map {|field| [field, 1]}.to_h
    end

  class IndexForm
    attr_accessor :submitted_status, :reviewed_status, :resubmitted_status

    def initialize(params_hash, session_hash)
      params_hash = params_hash.symbolize_keys
      session_hash = session_hash.symbolize_keys
      fields = %w(submitted_status reviewed_status resubmitted_status)
      if !params_hash.blank?
        fields.each do |s|
          self.send("#{s}=", params_hash[s.to_sym] || false)
        end
      elsif !session_hash.blank?
        fields.each do |s|
          self.send("#{s}=", session_hash[s.to_sym] || false)
        end
      end
    end

    def get_filter_statuses
      filter_statuses = []
      AppEditRequest.statuses.keys.map do |status|
        filter_statuses.append(AppEditRequest.statuses[status.to_sym]) unless self.send("#{status}_status").blank?
      end
      filter_statuses
    end

    def as_hash
      instance_variables.each_with_object({}) do |var, hash|
        (hash[var.to_s.delete('@')] =  self.instance_variable_get(var)) unless self.instance_variable_get(var).blank?
      end
    end
  end
end
