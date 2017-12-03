class IterationsController < ApplicationController

  before_action :set_iteration, :only => [:edit,:update,:destroy]
  before_action :set_engagement, :except => [:current_iteration, :get_customer_feedback]

  def index
    @stat = @engagement.summarize_customer_rating
  end

  def new
    if User.find_by_id(session[:user_id]).type_user == "staff"
			@iteration = @engagement.iterations.new
		else 
			redirect_to engagement_iterations_path(@engagement), alert: 'Error: Only staff can create iterations'
		end
    
  end

  def edit
    @feedback = JSON.parse(@iteration.customer_feedback)
    rescue (Exception)
      @feedback = Hash.new
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
    if User.find_by_id(session[:user_id]).type_user == "staff"
      feedback = feedback_params
      @iteration.customer_feedback = feedback.to_json
      new_end_date = params.require(:iteration).permit(:end_date)
      if @iteration.save and @iteration.update(new_end_date)
        redirect_to engagement_iterations_path(@engagement), notice: 'Iteration was successfully updated.'
      else
        render :edit
      end
    else 
			redirect_to engagement_iterations_path(@engagement), alert: 'Error: Only staff can edit iterations'
		end
  end

  # DELETE /engagements/1
  # DELETE /engagements/1.json
  def destroy
    if User.find_by_id(session[:user_id]).type_user == "staff"
      @iteration.destroy
      redirect_to engagement_iterations_path(@engagement), notice: 'Iteration was successfully destroyed.'
    else 
			redirect_to engagement_iterations_path(@engagement), alert: 'Error: Only staff can destroy iterations'
		end
  end

  def current_iteration
    iterations = Iteration.where(:customer_feedback => "").all()
    @iterations = iterations.map do |iter|
      [iter, iter.engagement]
    end
  end

  def get_customer_feedback
    iterations = Iteration.where(:customer_feedback => "").all()
    iterations = iterations.map do |iter|
      [iter, iter.engagement]
    end
    iterations.each do |iter, eng|
      unless PendingFeedback.exists?(:engagement_id => eng.id, :iteration_id => iter.id)
        pf = PendingFeedback.new
        pf.engagement = eng
        pf.iteration = iter
        pf.save

        host = request.env["REQUEST_URI"].split("/")[2]
        url = "http://#{host}/feedback/#{eng.id}/#{iter.id}"
        FormMailer.send_form(eng.contact.name, eng.contact.email, url).deliver_now
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def iteration_params
    params.require(:iteration).permit(:customer_feedback, :end_date)
  end

  def feedback_params
    params.require(:customer_feedback).permit(:duration, :demeanor,
      :engaged, :engaged_text, :communication,
      :communication_text, :understanding, :understanding_text,
      :effectiveness, :effectiveness_text, :satisfied, :satisfied_text)
  end

end
