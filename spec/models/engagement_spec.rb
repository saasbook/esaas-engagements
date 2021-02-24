require 'rails_helper'
require 'byebug'

describe Engagement do
    #Story ID: #153069725
    describe 'engagement associations' do

        it 'belongs to an app' do
            assc = described_class.reflect_on_association(:app)
            expect(assc.macro).to eq :belongs_to

        end
        
        it 'belongs to a coach' do
            assc = described_class.reflect_on_association(:coach)
            expect(assc.macro).to eq :belongs_to
        end
        
        it 'can access coach' do
            @user1 = User.new(:name => 'user1', :email => 'user1@email.com')
            @user2 = User.new(:name => 'user2', :email => 'user2@email.com')
            @eng = Engagement.new()
            @eng.coach = @user1
            expect(@eng.coach).to eq(@user1)
        end
        
        it 'has one coaching org' do
            assc = described_class.reflect_on_association(:coaching_org)
            expect(assc.macro).to eq :has_one
        end
        
        it 'can access coaching org' do
            @user1 = User.new(:name => 'user1', :email => 'user1@email.com')
            @org = Org.new(:name => 'org', :contact => @user1)
            @eng = Engagement.new()
            @eng.coach = @user1
            @eng.coaching_org = @org
            expect(@eng.coaching_org).to eq(@org)
        end
        
        it 'has one client org' do
            assc = described_class.reflect_on_association(:client_org)
            expect(assc.macro).to eq :has_one
        end
        
        it 'can access client org' do
            @user1 = User.new(:name => 'user1', :email => 'user1@email.com')
            @user2 = User.new(:name => 'user2', :email => 'user2@email.com')
            @org = Org.new(:name => 'org', :contact => @user1)
            @eng = Engagement.new()
            @eng.client_org = @org
            expect(@eng.client_org).to eq(@org)
        end
        
        it 'has one client' do
            assc = described_class.reflect_on_association(:client)
            expect(assc.macro).to eq :has_one
        end
        
        it 'can access client' do
            @user1 = User.create(:name => 'user1', :email => 'user1@email.com')
            @org = Org.create(:name => 'org', :contact => @user1)
            @app = App.create(:name => 'app', :description => 'wow', :org_id => 1, :status => :pending )
            @app.org = @org
            @eng = Engagement.create(:app_id => 1, :coach_id => 1, :team_number => '1', :start_date => DateTime.new(2017,2,3,4,5,6))
            @eng.client_org = @org
            expect(@eng.client).to eq(@user1)
        end
        
        it 'has many iterations' do
            assc = described_class.reflect_on_association(:iterations)
            expect(assc.macro).to eq :has_many
        end
        
        it 'has many developers' do
            assc = described_class.reflect_on_association(:developers)
            expect(assc.macro).to eq :has_many
        end
        
        it 'can access developers' do
            @dev1 = User.new(:name => 'dev1', :email => 'dev1@email.com')
            @dev2 = User.new(:name => 'dev2', :email => 'dev2@email.com')
            @eng = Engagement.new
            @eng.developers << [@dev1, @dev2]
            expect(@eng.developers).to eq [@dev1, @dev2]
        end

    end
    
    # Story ID: 176932021
    describe 'convert start date to semester' do
        it 'converts semesters' do
            eng = Engagement.new

            eng.start_date = DateTime.new(2017,2,3)
            expect(eng.get_semester()).to eq('SP17')

            eng.start_date = DateTime.new(2018,6,7)
            expect(eng.get_semester()).to eq('SU18')

            eng.start_date = DateTime.new(2019,9,10)
            expect(eng.get_semester()).to eq('FA19')
            
            # This needs an extra 8 because 8 hours gets subtracted from the datetime, unsure why
            eng.start_date = DateTime.new(2017,1,1,8)
            expect(eng.get_semester()).to eq('SP17')

            eng.start_date = DateTime.new(2017,5,15)
            expect(eng.get_semester()).to eq('SP17')

            eng.start_date = DateTime.new(2017,8,15)
            expect(eng.get_semester()).to eq('SU17')

            eng.start_date = DateTime.new(2017,8,16)
            expect(eng.get_semester()).to eq('FA17')

            eng.start_date = DateTime.new(2017,12,31,8)
            expect(eng.get_semester()).to eq('FA17')

            eng.start_date += 1.days
            expect(eng.get_semester()).to eq('SP18')
        end
        
    end

end