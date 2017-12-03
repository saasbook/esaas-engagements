require 'rails_helper'

describe User do
    #Story ID: #153069725
    describe 'User associations' do

        it 'belongs to a coaching org' do
            assc = described_class.reflect_on_association(:coaching_org)
            expect(assc.macro).to eq :belongs_to
        end
        
        it 'can access coaching org' do
            @user1 = User.new(:name => 'user1', :email => 'user1@email.com')
            @org = Org.new(:name => 'org', :contact => @user1)
            @user2 = User.new(:name => 'user2', :email => 'user2@email.com')
            @user2.coaching_org = @org
            expect(@user2.coaching_org).to eq(@org)
        end
        
        it 'belongs to a developing_engagement' do
            assc = described_class.reflect_on_association(:developing_engagement)
            expect(assc.macro).to eq :belongs_to
        end
        
        it 'can access developing_engagement' do
            @user1 = User.create(:name => 'user1', :email => 'user1@email.com')
            @org = Org.create(:name => 'org', :contact => @user1)
            @app = App.create(:name => 'app', :description => 'wow', :org_id => 1, :status => :pending )
            @app.org = @org
            @eng = Engagement.create(:app_id => 1, :coach_id => 1, :team_number => '1', :start_date => DateTime.new(2017,2,3,4,5,6))
            @user2 = User.new(:name => 'user2', :email => 'user2@email.com')
            @user2.developing_engagement = @eng
            expect(@user2.developing_engagement).to eq(@eng)
        end
        
        it 'has many comments' do
            assc = described_class.reflect_on_association(:comments)
            expect(assc.macro).to eq :has_many
        end
        
        it 'has many client orgs' do
            assc = described_class.reflect_on_association(:client_orgs)
            expect(assc.macro).to eq :has_many
        end
        
        it 'can access client orgs' do
            @user1 = User.create(:name => 'user1', :email => 'user1@email.com')
            @org1 = Org.new
            @org2 = Org.new
            @user1.client_orgs << [@org1, @org2]
            expect(@user1.client_orgs).to eq [@org1, @org2]
        end
        
        it 'has many coaching engagements' do
            assc = described_class.reflect_on_association(:coaching_engagements)
            expect(assc.macro).to eq :has_many
        end
        
        it 'can access coaching engagements' do
            @user1 = User.create(:name => 'user1', :email => 'user1@email.com')
            @eng1 = Engagement.new
            @eng2 = Engagement.new
            @user1.coaching_engagements << [@eng1, @eng2]
            expect(@user1.coaching_engagements).to eq [@eng1, @eng2]
        end
        
        it 'has many apps' do
            assc = described_class.reflect_on_association(:apps)
            expect(assc.macro).to eq :has_many
        end
        
        it 'has many client engagements' do
            assc = described_class.reflect_on_association(:client_engagements)
            expect(assc.macro).to eq :has_many
        end
        
        it 'can access client engagements' do
            @user1 = User.create(:name => 'user1', :email => 'user1@email.com')
            @user2 = User.create(:name => 'user2', :email => 'user2@email.com')
            
            @org1 = Org.create(:name => 'org1', :contact => @user1)
            @org2 = Org.create(:name => 'org2', :contact => @user2)
            
            @app1 = App.create(:name => 'app1', :description => 'wow', :org_id => 1, :status => :pending )
            @app1.org = @org1
            
            @app2 = App.create(:name => 'app2', :description => 'woah', :org_id => 2, :status => :pending )
            @app2.org = @org2
            
            @eng1 = Engagement.create(:app_id => 1, :coach_id => 1, :team_number => '1', :start_date => DateTime.new(2017,2,3,4,5,6))
            @eng1.client_org = @org1
            
            @eng2 = Engagement.create(:app_id => 2, :coach_id => 2, :team_number => '2', :start_date => DateTime.new(2017,2,3,4,5,6))
            @eng2.client_org = @org2
            
            @user3 = User.create(:name => 'user3', :email => 'user3@email.com')
            @user3.client_orgs << [@org1, @org2]
            expect(@user3.client_engagements).to eq [@eng1, @eng2]
        end

    end

end