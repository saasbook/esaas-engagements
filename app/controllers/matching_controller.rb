class MatchingController < ApplicationController

  
  def index
    @matchings = Matching.all
    @currentPreference = Matching.find_or_create_by(:id => 1).preferences
    if current_user&.coach?
      render 'index'
    else 
      render 'show'
    end
    
    # [["Matching 1", "Complete", 1], ["Matching 2", "In Progress", 2], ["Matching 3", "Complete", 3]]

  end

  # GET /matching/new
  def new
    @matching = Matching.first
  end

  def show
    @mockMatching = params[:matching_id]
    @mockProjectsHash = {
                        "AFX Dance": "Create a website that allows admins of different levels in AFX Dance to organize their audition process and pick dancers.",
                        "BCal API Integration": "Unified portal for event requests and calendar management after transition from Oracle Calendar.",
                        "CS61 series Lab assistant check-in": "Sign in portal for the 61 series lab assistants"
                        }
    @currentPreference = ["AFX Dance"]
    # Matching.find_or_create_by(:id => 1).preferences
  end

  def progress
    @mockMatching = params[:matching_id]
    @mockStudents = [["Team 1", "Complete", 1], ["Team 2", "In Progress", 2], ["Team 3", "Complete", 3]]
  end

  def store
      @match = Matching.find_or_create_by(:id => 1)
      preference = params[:preferences]
      @match.update_attributes(:preferences => preference)
  end

end
