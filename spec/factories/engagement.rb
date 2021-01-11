FactoryBot.define do
  factory :engagement do
    association :app
    association :coaching_org, :factory => :org
    association :coach, :factory => :user
    sequence(:team_number) { |n| n }
    start_date { 1.year.ago }
    student_names { "stu1, stu2, stu3" }
  end
end
