class Iteration < ActiveRecord::Base

  belongs_to :engagement
  validates_presence_of :engagement_id
  validates_associated :engagement

  validates_presence_of :end_date

  default_scope { order('end_date ASC') }

  def customer_feedback_to_hash
  	JSON.parse customer_feedback rescue Hash.new
  end

  def customer_rating
    Hash[
      customer_feedback_with_rating
      .to_a
      .map{|k,v| [k, Iteration.rating_to_score(v)]}
    ]
  end

  def customer_feedback_with_rating
    customer_feedback_to_hash.select do |key, value|
      Iteration.customer_rating_keys.include? key
    end
  end

  def self.create_base_rating_hash
    Hash[self.customer_rating_keys.map {|key| [key, 0]}]
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
  	self.ratings[rating]
  end
end
