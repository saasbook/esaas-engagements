require 'rails_helper'
require 'spec_helper'

describe OrgsController, type: :controller do
    before do
      allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)

      @test_address = "test@cs169.com"
      @test_subject = "Hello from cs169 team"
      @test_content = "Hello all, this is a rspec test email."
    end

    describe 'when mailing to all organizaitons' do
      it 'redirects orgs page if mailing to all organizations successfully' do
        post :mail_all_orgs, :email => {:address => @test_address, :subject => @test_subject, :content => @test_content}
        expect(subject).to redirect_to :action => :index
      end

    end
  end