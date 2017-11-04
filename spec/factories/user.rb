FactoryGirl.define do
  factory :user do
  	name "user1"
  	email "user1@gmail.com"
  	github_uid { 1.year.ago }
  	created_at { 1.year.ago }
  	updated_at { 1.year.ago }
  	preferred_contact "by email"
  end
end
