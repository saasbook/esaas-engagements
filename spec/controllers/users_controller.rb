require 'rails_helper'
require 'spec_helper'

describe UsersController, type: :controller do
  before do
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
    @user = FactoryGirl.create(:user)
    @user_params = {:name => "user1",:email=>"user1@gmail.com",:preferred_contact=>"by email",:github_uid => "fakeuid"}

  end

  describe 'create user' do
    it 'redirects to user page if cannot create user' do
      allow(User).to receive(:new).and_return(@user)
      post :create, :user => @user_params
      expect(subject).to redirect_to :action => :index
    end
    it 'redirects to users page if user created successfully' do
      allow(User).to receive(:new).and_return(@user)
      post :create, :user => @user_params
      expect(response).to redirect_to(users_path)    
    end

    it 'displays a success notice if user created successfully' do
      allow(User).to receive(:new).and_return(@user)
      post :create, :user => @user_params
      expect(flash[:notice]).to match(/^User successfully created.$/)
    end

  end
end