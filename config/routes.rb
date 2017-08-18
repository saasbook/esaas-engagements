Rails.application.routes.draw do
  # OmniAuth authentication with GitHub
  get 'login' => 'session#login', :as => 'login'
  match  'auth/:provider/callback' => 'session#create', :via => [:get, :post]
  get 'auth/failure' => 'session#failure'
  get 'logout' => 'session#destroy'

  # route /apps/:app_id/engagements/:engagement_id
  resources :apps do
    resources :engagements, :except => :index
  end
  # route /engagements/:engagement_id/iterations/:iteration_id
  resources :engagements, :only => [] do # don't route engagements by themselves
    resources :iterations
  end
  resources :orgs
  resources :users, :only => [:index, :new, :edit, :create, :update]
  root :to => 'apps#index'
end
