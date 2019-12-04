class IterationsController < ApplicationController

  before_action :set_iteration, :only => [:edit,:update,:destroy]
  before_action :set_engagement, :except => [:current_iteration, :get_customer_feedback]
  before_action :auth_user?, only: [:new, :create, :edit, :update, :destroy]

  def index
    @stat = @engagement.summarize_customer_rating
  end

  def new
    @iteration = @engagement.iterations.new
  end

  def edit
    @feedback = JSON.parse(@iteration.customer_feedback)
    rescue (Exception)
      @feedback = Hash.new
      # flash[:alert] = "Customer Feedback does not have editable format."
      # redirect_to engagement_iterations_path
  end

  def create
    @iteration = @engagement.iterations.build(iteration_params)
    if @iteration.save
      redirect_to engagement_iterations_path(@engagement), notice: 'Iteration was successfully created.'
    else
      render :new
    end
  end

  def update
    feedback = feedback_params
    @iteration.customer_feedback = feedback.to_json
    new_params = params.require(:iteration).permit(:number, :end_date, :general_feedback)
    if @iteration.save and @iteration.update(new_params)
      redirect_to engagement_iterations_path(@engagement), notice: 'Iteration was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /engagements/1
  # DELETE /engagements/1.json
  def destroy
    @iteration.destroy
    redirect_to engagement_iterations_path(@engagement), notice: 'Iteration was successfully destroyed.'
  end

  def current_iteration
    iterations = Iteration.where(:customer_feedback => [nil, ""]).all
    @iterations = iterations.map do |iter|
      [iter, iter.engagement]
    end
  end

  def get_customer_feedback
    iterations = Iteration.where(:customer_feedback => [nil, ""]).all
    iterations = iterations.map do |iter|
      [iter, iter.engagement]
    end
    iterations.each do |iter, eng|
      unless PendingFeedback.exists?(:engagement_id => eng.id, :iteration_id => iter.id)
        pf = PendingFeedback.new
        pf.engagement = eng
        pf.iteration = iter
        pf.save

        host = request.host_with_port
        url = "http://#{host}/feedback/#{eng.id}/#{iter.id}"
        FormMailer.send_form(eng.app.org.contact.name, eng.app.org.contact.email, url, iter, eng).deliver_now
      end 
    end
    redirect_to current_iteration_path
  end

  private

  def set_iteration
    @iteration = Iteration.find(params[:id])
  end

  def set_engagement
    @engagement = Engagement.find(params[:engagement_id])
  end

  def iteration_params
    params.require(:iteration).permit(:customer_feedback, :end_date, :number, :general_feedback)
  end

  def feedback_params
    params.require(:iteration).require(:customer_feedback).permit(:duration,
      :demeanor, :demeanor_text, :engaged, :engaged_text, :communication,
      :communication_text, :understanding, :understanding_text,
      :effectiveness, :effectiveness_text, :satisfied, :satisfied_text)
  end

  def auth_user?
    redirect_path unless User.find_by_id(session[:user_id])&.coach? || User.find_by_id(session[:user_id])&.client?
  end

end
