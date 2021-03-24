class MatchingController < ApplicationController

  
  def index
    @mockMatchings = [["Matching 1", "Complete"], ["Matching 2", "In Progress"], ["Matching 3", "Complete"]]

  end

  # GET /matching/new
  def new
    
  end
end
