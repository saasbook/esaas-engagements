require 'rails_helper'

describe AppEditRequest do

    before :each do
        @invalid_request = build(:app_edit_request, description: '', features: '')
        @valid_missing_features = build(:app_edit_request, features: '')
        @valid_missing_description = build(:app_edit_request, description: '')
    end

    context 'validation' do
        describe 'at_least_one_filled' do
            before :each do
              allow(App).to receive(:find).and_return(FactoryBot.create(:app))
            end
            it 'should not be valid if both description and features are empty' do
                expect(@invalid_request).to_not be_valid
            end

            it 'should be valid if either one of description and features is non-empty' do
                expect(@valid_missing_features).to be_valid
                expect(@valid_missing_description).to be_valid
            end
        end

        describe 'has_edits_if_filled' do
            before do
                user = FactoryBot.create(:user, name: "App Owner")
                org  = FactoryBot.create(:org, name: "App Org", contact_id: user.id)
                @app  = FactoryBot.create(
                  :app,
                  org_id: org.id,
                  name: "Application",
                  description: "same description",
                  features: "same features"
                )
                allow(App).to receive(:find).with(@app.id).and_return(@app)
            end
          it 'should be invalid if features and description are the same' do
            req_with_same_features = FactoryBot.build(
                :app_edit_request,
                app_id: @app.id,
                features: 'same features',
                description: 'same description'
            )
            expect(req_with_same_features).to_not be_valid
          end
        end
        describe 'valid attributes upon initialization' do
            before :each do
              allow(App).to receive(:find).and_return(FactoryBot.create(:app))
            end
            it 'should belong to an app' do
                expect(@valid_missing_features.app_id).to_not eq(nil)
            end

            it 'should belong to a requester' do
                expect(@valid_missing_features.requester_id).to_not eq(nil)
            end
            
            it 'should have a status' do
                expect(@valid_missing_features.status).to_not eq(nil)
            end
        end
    end
end