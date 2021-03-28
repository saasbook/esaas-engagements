class MatchingController < ApplicationController

  
  def index
    @mockMatchings = [["Matching 1", "Complete", 1], ["Matching 2", "In Progress", 2], ["Matching 3", "Complete", 3]]

  end

  # GET /matching/new
  def new
    
  end

  def show
    @mockMatching = params[:matching_id]
    
  end

  def progress
    @mockMatching = params[:matching_id]
    @mockStudents = [["Student 1", "Complete", 1], ["Student 2", "In Progress", 2], ["Student 3", "Complete", 3]]

  end

  def store
      @match = Matching.find_or_create_by(:id => 1)
      preference = @match.preference.append(params[:preference])
      @match.update_attributes(:preference => preference)
  end


end
