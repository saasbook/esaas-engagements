FactoryGirl.define do
  factory :iteration do
  	engagement_id { 1 }
  	customer_feedback {{"duration"=>"15 min", "demeanor"=>"Strongly agree", "engaged"=>"Strongly agree", \
  		"engaged_text"=>"i", "communication"=>"Strongly agree", "communication_text"=>"i", \
  		"understanding"=>"Strongly agree", "understanding_text"=>"i", "effectiveness"=>"Strongly agree", \
  		"effectiveness_text"=>"i", "satisfied"=>"Strongly agree", "satisfied_text"=>"i"}}
  	end_date { 1.year.ago}
  	created_at {1.year.ago}
  	updated_at {1.year.ago}
  end
end