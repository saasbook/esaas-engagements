FactoryBot.define do
    factory :app_edit_request do
        description {'description'}
        features {'feature'}
        association :app, factory: :app
        association :requester, factory: :user
    end 
end