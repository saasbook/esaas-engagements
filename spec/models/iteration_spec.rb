require 'rails_helper'

describe Iteration do
	describe 'parses customer feedback into a hash' do
		it 'calls JSON.parse to parse a string into a ruby hash' do
			expect(JSON).to receive(:parse)
			Iteration.new.customer_feedback_to_hash
		end

		it 'converts a string of valid JSON format into ruby Hash' do
			@iteration = FactoryGirl.build(:iteration, :customer_feedback => "{\"a\":\"1\",\"b\":\"2\"}")
			expect(@iteration.customer_feedback_to_hash).to eq({"a" => "1", "b" => "2"})
		end

		it 'returns an empty ruby Hash if customer feedback is not a valid JSON format' do
			@iteration1 = FactoryGirl.build(:iteration, :customer_feedback => "")
			@iteration2 = FactoryGirl.build(:iteration, :customer_feedback => "asdasd")
			expect(@iteration1.customer_feedback_to_hash).to be_empty
			expect(@iteration2.customer_feedback_to_hash).to be_empty
		end
	end

	describe 'maps a customer rating into a score' do
		it 'maps "Strongly agree" into 5' do
			expect(Iteration.rating_to_score "Strongly agree").to eq(5)
		end
		it 'maps "Mostly agree" into 4' do
			expect(Iteration.rating_to_score "Mostly agree").to eq(4)
		end
		it 'maps "Neither agree nor disagree" into 3' do
			expect(Iteration.rating_to_score "Neither agree nor disagree").to eq(3)
		end
		it 'maps "Mostly disagree" into 2' do
			expect(Iteration.rating_to_score "Mostly disagree").to eq(2)
		end
		it 'maps "Strongly disagree" into 1' do
			expect(Iteration.rating_to_score "Strongly disagree").to eq(1)
		end
		it 'maps an invalid rating into nil' do
			expect(Iteration.rating_to_score "INVLAIDRAITNG").to be_nil
		end
	end

	describe 'can filter the customer feedback by items with a rating' do
		it 'selects only keys that maps to a rating' do
			@iteration = FactoryGirl.build(:iteration)
			expect(@iteration.customer_feedback_with_rating.keys).to eq(Iteration.customer_rating_keys)
		end

		it 'returns an empty hash if the customer feedback does not hae a valid JSON format' do
			@iteration = FactoryGirl.build(:iteration, :customer_feedback => "This team is really great!")
			expect(@iteration.customer_feedback_with_rating).to be_empty
		end
	end

	describe 'turns a customer feedback into a hash with only ratings converted to scores' do
		before :each do
			@iteration = FactoryGirl.build(:iteration)
		end

		it 'calls Iteration#customer_feedback_with_rating to filter out the non-rating keys' do
			expect(@iteration).to receive(:customer_feedback_with_rating)
			@iteration.customer_rating
		end

		it 'if customer_feedback has a valid JSON format, it only has customer ratings' do
			expect(@iteration.customer_rating.keys).to eq(Iteration.customer_rating_keys)
		end

		it 'if customer_feedback has an invalid JSON format, it returns an empty hash' do
			@iteration = FactoryGirl.build(:iteration, :customer_feedback => "some random invalid feedback")
			expect(@iteration.customer_rating).to be_empty
		end

		it 'maps each rating into a score' do
			@iteration.customer_rating.each do |key, value|
				expect(value).to eq(Iteration.rating_to_score @iteration.customer_feedback_with_rating[key])
			end
		end
	end

	it 'contains a list of keys that relate to customer ratings' do
		expect(Iteration.customer_rating_keys).to eq(%w(demeanor engaged communication understanding effectiveness satisfied))
	end

	it 'contains a list of keys that relate to customer feedback' do
		expect(Iteration.customer_text_keys).to eq(%w(demeanor_text engaged_text communication_text understanding_text effectiveness_text satisfied_text))
	end
	it 'conatins a hash that maps a customer rating to a score' do
		expect(Iteration.ratings).to eq({"Strongly agree" => 5, "Mostly agree" => 4, "Neither agree nor disagree" => 3, \
  		"Mostly disagree" => 2, "Strongly disagree" => 1})
	end
	it 'creates a bash hash for storing summary statistics' do
		expect(Iteration.create_base_rating_hash).to eq({"demeanor" => 0, "engaged" => 0, "communication" => 0, \
		"understanding" => 0, "effectiveness" => 0, "satisfied" => 0})
	end
	it 'contains a list of rating options' do
		expect(Iteration.rating_options).to eq ['Strongly agree', 'Mostly agree', 'Neither agree nor disagree', 'Mostly disagree', 'Strongly disagree']
	end
	it 'contains a list of duration options' do
		expect(Iteration.duration_options).to eq ['15 min', '30 min', '45 min', '1 hour', '1 hour 15 min', '1 hour 30 min', 'Longer than 1 hour 30 min']
	end
end