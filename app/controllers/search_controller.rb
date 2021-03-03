class SearchController < ApplicationController
  skip_before_filter :logged_in?, :only => :public_search

  def search
    keyword = params["keyword"]
    all_filters = ["Apps", "Organizations", "Users", "Semesters"]
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
    keyword = params["keyword"]
    @filters = session[:filters]
    @apps = []
    @orgs = []
    @users = []
    if no_need_to_access_database(keyword)
      return
    end
    
    if @filters.include?("Apps")
      keyword = ("%" + keyword + "%").downcase
      @apps = App.where('lower(name) LIKE ?', keyword).all() | App.where('lower(description) LIKE ?', keyword).all()
    end
    if @filters.include?("Organizations")
      keyword = ("%" + keyword + "%").downcase
      @orgs = Org.where('lower(name) LIKE ?', keyword).all()
    end
    if @filters.include?("Users")
      keyword = ("%" + keyword + "%").downcase
      emails = User.where('lower(email) LIKE ?', keyword).all()
      name = User.where('lower(name) LIKE ?', keyword).all()
      github = User.where('lower(github_uid) LIKE ?', keyword).all()
      @users = (emails + name + github).uniq
    end
    if @filters.include?("Semesters")
      keywords = keyword.downcase.split(/(?<=[a-z])\s*(?=\d)/).map{|string| "%" + string + "%"}
      if (keywords.length == 1) 
        keywords[1] = keywords[0]
      end
      @apps = App.joins(:engagements).select("apps.*, semester").where("lower(semester) LIKE ? AND lower(semester) LIKE ?", keywords[0], keywords[1]).all
      # else 
      #   @apps = @apps.joins(:engagements).where("lower(semester) LIKE ?", keyword).all
    end
  end

  def public_search
    keyword = "%#{params[:keyword]}%".downcase
    @apps = App.where('lower(name) LIKE ? OR lower(description) LIKE ?', keyword, keyword).all()
  end

  def no_need_to_access_database(keyword)
    return @filters.nil? || keyword.empty?
  end

  


end

