class SearchController < ApplicationController

  def search
    keyword = params["keyword"]
    filters = params[:search_filters]
    @all_filters = ["App", "Organization", "User"]
    if keyword.empty?
      flash[:notice] = "Please enter a keyword in the search box."
      redirect_to results_path(:keyword => "", :search_filters => @all_filters) and return 
    elsif filters.nil?
      flash[:notice] = "Please at least choose one category you want to search."
      redirect_to results_path(:keyword => "", :search_filters => @all_filters) and return 
    end
    flash[:notice] = "Search #{keyword} according to the filters #{params[:search_filters].map{|x| x.inspect}.join(', ')}."
    redirect_to results_path(:keyword => keyword, :search_filters => filters)
  end

  def results
    keyword = ("%" + params["keyword"] + "%").downcase
    filters = params[:search_filters]
    if filters.include?("App")
      @apps = App.where('lower(name) LIKE ?', keyword).all() | App.where('lower(description) LIKE ?', keyword).all()
    else
      @apps = []
    end
    if filters.include?("Organization")
      @orgs = Org.where('lower(name) LIKE ?', keyword).all()
    else
      @orgs = []
    end
    if filters.include?("User")
      @users = User.where('lower(name) LIKE ?', keyword).all()
    else
      @users = []
    end
  end
end