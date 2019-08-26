FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user #{n}" }
    sequence(:email) { |n| "user#{n}@gmail.com" }
    sequence(:github_uid) { |n| "user#{n}" }
    created_at { 1.year.ago }
    updated_at { 1.year.ago }
    preferred_contact { "by email" }
  end
end
