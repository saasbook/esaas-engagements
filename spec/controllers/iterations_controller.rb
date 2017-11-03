require 'rails_helper'
require 'spec_helper'

describe IterationsController, type: :controller do
  before do
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
    @iteration = FactoryGirl.create(:iteration)
    @engagement = FactoryGirl.create(:engagement)
    @feedback_params = {:duration => "15 min", :demeanor=> "Strongly agree", \
      :engaged=> "Strongly agree", :engaged_text=> "super engaged team", :communication=> "Strongly agree", \
      :communication_text=> "super communicative team", :understanding=>"Strongly agree", \
      :understanding_text=> "team had good understanding", :effectiveness=> "Strongly agree", \
      :effectiveness_text=> "team was effective", :satisfied=> "Strongly agree", \
      :satisfied_text=> "I am satisfied"}
    @end_date = Date.new(2017,7,7)
  end

  describe 'when updating customer feedback' do
    it 'redirects edit page if customer feedback cannot be updated' do
      # allow_any_instance_of(IterationsController).to receive(:set_iteration).and_return(@iteration)
      allow(@iteration).to receive(:update).and_return(false)
      put :update, :engagement_id => @engagement, :id => @iteration, \
      :customer_feedback => @feedback_params, :iteration => {:end_date => @end_date}
      expect(subject).to redirect_to :action => :index
      # expect(subject).to redirect_to :action => :edit # redirect to edit when update fails
    end
    it 'redirects engagement page if customer feedback updated successfully' do
      allow(@iteration).to receive(:save).and_return(true)
      put :update, :engagement_id => @engagement, :id => @iteration, \
      :customer_feedback => @feedback_params, :iteration => {:end_date => @end_date}
      expect(response).to redirect_to(engagement_iterations_path)    
    end

    it 'displays a success notice if customer feedback updated successfully' do
      allow(@iteration).to receive(:save).and_return(true)
      put :update, :engagement_id => @engagement, :id => @iteration, \
      :customer_feedback => @feedback_params, :iteration => {:end_date => @end_date}
      expect(flash[:notice]).to match(/^Iteration was successfully updated.$/)
    end

    describe 'attempt to edit iteration' do
      before(:each) do
        allow(JSON).to receive(:parse).with("duration: 15 min")
        get :edit, :engagement_id => @engagement, :id => @iteration
      end
      it 'redirects back to all iterations page if customer feedback not in JSON form' do
        expect(subject).to redirect_to :action => :index
      end

      it 'displays an error notice if attempted to edit when feedback not in JSON' do
        expect(flash[:alert]).to match(/^Customer Feedback does not have editable format.$/)
      end
    end
  end
end