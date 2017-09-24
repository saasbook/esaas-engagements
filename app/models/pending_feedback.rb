class PendingFeedback < ActiveRecord::Base
	belongs_to :engagement
	belongs_to :iteration
end
