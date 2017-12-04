FactoryGirl.define do
  factory :org do
  	name 'CS169'
  	description 'Software Engineering'
  	contact_id 2
  	address_line_1 '1234 Berkeley St.'
  	address_line_2 'APT #2'
  	city_state_zip 'Berkeley, CA 94704'
  	phone '510-232-1232'
  end
end
