class IterationsController < ApplicationController

  before_action :set_iteration, :only => [:edit,:update,:destroy]
  before_action :set_engagement, :except => [:current_iteration, :get_customer_feedback]

  def index ; end

  def new
    @iteration = @engagement.iterations.new
  end
  def edit ; end

  def create
    @iteration = @engagement.iterations.build(iteration_params)
    if @iteration.save
      redirect_to engagement_iterations_path(@engagement), notice: 'Iteration was successfully created.'
    else
      render :new
    end
  end

  def update
    if @iteration.update(iteration_params)
      redirect_to engagement_iterations_path(@engagement), notice: 'Iteration was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /engagements/1
  # DELETE /engagements/1.json
  def destroy
    @iteration.destroy
    redirect_to @app, notice: 'Engagement was successfully destroyed.'
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

end
