class SearchController < ApplicationController

  def search
    keyword = params["keyword"]
    @all_filters = ["App_search", "Organization_search", "User_search"]
    filters = []
    @all_filters.each do |filter|
      if params[filter] == "1"
        filters += [filter]
      end
    end
    if keyword.empty?
      flash[:notice] = "Please enter a keyword in the search box."
      redirect_to results_path(:keyword => "", :filters => @all_filters) and return 
    elsif filters.empty?
      flash[:notice] = "Please at least choose one category you want to search."
      redirect_to results_path(:keyword => "", :filters => []) and return 
    end
    flash[:notice] = "Search #{keyword} according to the filters #{filters.map{|x| x.inspect}.join(', ')}."
    redirect_to results_path(:keyword => keyword, :filters => filters)
  end

  def results
    keyword = ("%" + params["keyword"] + "%").downcase
    filters = params[:filters]
    @apps = []
    @orgs = []
    @users = []
    if filters.nil?
      return
    end
    if filters.include?("App_search")
      @apps = App.where('lower(name) LIKE ?', keyword).all() | App.where('lower(description) LIKE ?', keyword).all()
    end
    if filters.include?("Organization_search")
      @orgs = Org.where('lower(name) LIKE ?', keyword).all()
    end
    if filters.include?("User_search")
      @users = User.where('lower(name) LIKE ?', keyword).all()
    end
  end
end