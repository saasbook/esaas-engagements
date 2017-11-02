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
  end

  describe 'when updating customer feedback' do
    it 'redirects edit page if customer feedback cannot be updated' do
      allow(@iteration).to receive(:save).and_return(false)
      # allow(JSON).to receive(:parse).and not_to raise_error
      # allow(JSON).to receive(:parse).with(@iteration.customer_feedback)
      put :update, :engagement_id => @engagement, :id => @iteration, \
      :customer_feedback => @feedback_params
      # expect(JSON).to receive(:parse).with(@iteration.customer_feedback).and_return({"duration"=>"15 min", "demeanor"=>"Strongly agree", "engaged"=>"Strongly agree", "engaged_text"=>"i", "communication"=>"Strongly agree", "communication_text"=>"i", "understanding"=>"Strongly agree", "understanding_text"=>"i", "effectiveness"=>"Strongly agree", "effectiveness_text"=>"i", "satisfied"=>"Strongly agree", "satisfied_text"=>"i"})
      expect(subject).to redirect_to :action => :index
      # expect(subject).to redirect_to :action => :edit
    end
    it 'redirects engagement page if customer feedback updated successfully' do
      allow(@iteration).to receive(:save).and_return(true)
      put :update, :engagement_id => @engagement, :id => @iteration, \
      :customer_feedback => @feedback_params
      expect(response).to redirect_to(engagement_iterations_path)    
    end

    it 'displays a success notice if customer feedback updated successfully' do
      allow(@iteration).to receive(:save).and_return(true)
      put :update, :engagement_id => @engagement, :id => @iteration, \
      :customer_feedback => @feedback_params
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