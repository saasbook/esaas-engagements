FactoryGirl.define do
  factory :engagement do
  	app_id { 1 }
  	coaching_org_id { 1 }
  	coach_id { 1 }
  	team_number { 1 }
  	start_date { 1.year.ago }
  	student_names "stu1, stu2, stu3"
  end
end