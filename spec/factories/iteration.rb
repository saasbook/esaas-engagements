FactoryGirl.define do
  factory :iteration do
  	engagement_id { 1 }
  	customer_feedback {"{\"duration\":\"45 min\",\"demeanor\":\"Strongly agree\",\"engaged\":\"Mostly agree\",\"engaged_text\":\"Everyone was engaged\",\"communication\":\"Strongly agree\",\"communication_text\":\"good\",\"understanding\":\"Strongly agree\",\"understanding_text\":\"nice\",\"effectiveness\":\"Strongly agree\",\"effectiveness_text\":\"believe in them\",\"satisfied\":\"Strongly agree\",\"satisfied_text\":\"Love the features\"}"}
  	end_date { 1.year.ago}
  	created_at {1.year.ago}
  	updated_at {1.year.ago}
  end
end
