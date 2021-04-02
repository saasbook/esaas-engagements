class PendingFeedbackController < ApplicationController
	skip_before_filter :logged_in?

	def form
		@engagement = Engagement.find(params[:engagement_id])
		@iteration = Iteration.find(params[:iteration_id])
		@customer = @engagement.client.name
	end

	def process_response
		feedback = params.permit(:duration, :demeanor,
			:engaged, :communication, :understanding,
			:opportunity_to_try, :effectiveness, :satisfied, :general_feedback)
		iteration = Iteration.find(params[:iteration_id])
		iteration.customer_feedback = feedback.to_json
    iteration.general_feedback = feedback[:general_feedback]
		iteration.save
		pf = PendingFeedback.where(:engagement_id => params[:engagement_id], :iteration_id => params[:iteration_id]).first()
		pf.destroy
	end
end
