class SearchController < ApplicationController

  def search
    keyword = params["keyword"]
    all_filters = ["Apps", "Organizations", "Users"]
    filters = all_filters.select {|filter| params[filter]} 
    session[:filters] = filters

    if filters.empty?
      redirect_to results_path(:keyword => keyword), alert: "Please choose at least one category"
    elsif keyword.empty?
        redirect_to results_path(:keyword => ''), alert: "Please enter a keyword in the search box"
    else
      flash[:notice] = "Search '#{keyword.strip}' in #{filters.map{|x| x.inspect}.join(', ')}"
      redirect_to results_path(:keyword => keyword)
    end
  end

  def results
    keyword = ("%" + params["keyword"].strip + "%").downcase
    @filters = session[:filters] || all_filters
    @apps = []
    @orgs = []
    @users = []
    if @filters.nil?
      return
    end
    if @filters.include?("Apps")
      @apps = App.where('lower(name) LIKE ?', keyword).all() | App.where('lower(description) LIKE ?', keyword).all()
    end
    if @filters.include?("Organizations")
      @orgs = Org.where('lower(name) LIKE ?', keyword).all()
    end
    if @filters.include?("Users")
      @users = User.where('lower(name) LIKE ?', keyword).all()
    end
  end
end