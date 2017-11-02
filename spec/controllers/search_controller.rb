require 'rails_helper'
require 'spec_helper'

describe SearchController , type: :controller do
    
   before(:each) do
        # fake_user = double('User',:name => 'user1', :email => 'test@user.com', :github_uid => 'esaas-developer')
        # user = FactoryGirl.create(:user, name => 'user1', email => 'test@user.com', github_uid => 'esaas-developer')
        allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)

    end
     
    describe 'search' do
        it 'redirects params to results_path' do
           post :search, {:keyword => 'fake_search'}
           expect(subject).to redirect_to :action => :results
        end
    end
   

end