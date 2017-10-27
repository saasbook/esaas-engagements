class SearchController < ApplicationController

  def search
    keyword = params["keyword"]
    redirect_to results_path(:keyword => keyword)
  end

  def results
    keyword = "%" + params["keyword"] + "%"
    @apps = App.where('name LIKE ?', keyword).all()
    @orgs = Org.where('name LIKE ?', keyword).all()
    @users = User.where('name LIKE ?', keyword).all()
  end
end
