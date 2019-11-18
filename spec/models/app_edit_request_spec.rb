require 'rails_helper'

describe AppEditRequest do

    before :each do
        @invalid_request = build(:app_edit_request)
        @request1 = build(:app_edit_request, :description => 'I want X feature')
        @request2 = build(:app_edit_request, :features => 'X')
    end

    context 'validation' do
        describe 'at_least_one_filled' do
            it 'should not be valid if both description and features are empty' do
                expect(@invalid_request).to_not be_valid
            end

            it 'should be valid if either one of description and features is non-empty' do
                expect(@request1).to be_valid
                expect(@request2).to be_valid
            end
        end

        describe 'valid attributes upon initialization' do
            it 'should belong to an app' do
                expect(@request1.app_id).to_not eq(nil)
            end

            it 'should belong to a requester' do
                expect(@request1.requester_id).to_not eq(nil)
            end
            
            it 'should have a status' do
                expect(@request1.status).to_not eq(nil)
            end
        end
    end
end