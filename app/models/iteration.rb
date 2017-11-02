class Iteration < ActiveRecord::Base

  belongs_to :engagement
  validates_presence_of :engagement_id
  validates_associated :engagement

  validates_presence_of :end_date

  default_scope { order('end_date ASC') }

  def customer_feedback_to_hash
  	JSON.parse customer_feedback rescue nil
  end

  def customer_rating
  	customer_rating = customer_feedback_to_hash
  	unless customer_rating.nil?
	  	return customer_rating.each{|k, v| customer_rating[k] = Iteration.rating_to_score v} \
	  							.select{|k, v| Iteration.customer_rating_keys.include? k}
  	end
  	return nil
  end

  def self.customer_rating_keys
  	%w(demeanor engaged communication understanding effectiveness satisfied)
  end

  def self.customer_text_keys
    %w(engaged_text communication_text understanding_text effectiveness_text satisfied_text)
  end

  def self.ratings
  	{"Strongly agree" => 5, "Mostly agree" => 4, "Neither agree nor disagree" => 3, \
  		"Mostly disagree" => 2, "Strongly disagree" => 1}
  end

  def self.rating_to_score(rating)
  	self.ratings[rating] if self.ratings.keys.include? rating
  end
end
