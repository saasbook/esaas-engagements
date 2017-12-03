class PendingFeedbackController < ApplicationController
	skip_before_filter :logged_in?

	def form
		@engagement = Engagement.find(params[:engagement_id])
		@iteration = Iteration.find(params[:iteration_id])
		@customer = @engagement.client.name
	end

	def process_response
		feedback = params.permit(:duration, :demeanor,
			:engaged, :engaged_text, :communication,
			:communication_text, :understanding, :understanding_text,
			:effectiveness, :effectiveness_text, :satisfied, :satisfied_text)
		iteration = Iteration.find(params[:iteration_id])
		iteration.customer_feedback = feedback.to_json
		iteration.save
		pf = PendingFeedback.where(:engagement_id => params[:engagement_id], :iteration_id => params[:iteration_id]).first()
		pf.destroy
	end
end