require 'json'

class MatchingController < ApplicationController

  
  def index
    @mockMatchings = [["Matching 1", "Complete", 1], ["Matching 2", "In Progress", 2], ["Matching 3", "Complete", 3]]

  end

  # GET /matching/new
  def new
    
  end

  def show
    @mockMatching = params[:matching_id]
    @mockProjectsHash = {
                        "AFX Dance": "Create a website that allows admins of different levels in AFX Dance to organize their audition process and pick dancers.",
                        "BCal API Integration": "Unified portal for event requests and calendar management after transition from Oracle Calendar.",
                        "CS61 series Lab assistant check-in": "Sign in portal for the 61 series lab assistants"
                        }
                    
    @currentPreference = JSON.parse Matching.find_or_create_by(:id => 1, :preference => ["lol", "hah"]).preference
  end

  def progress
    @mockMatching = params[:matching_id]
    @mockStudents = [["Team 1", "Complete", 1], ["Team 2", "In Progress", 2], ["Team 3", "Complete", 3]]
  end

  def store
      @match = Matching.find_or_create_by(:id => 1)
      preference = params[:preference]
      @match.update_attributes(:preference => preference)
  end

end
