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
  resources :orgs, :except => :show
  resources :users, :only => [:index, :new, :edit, :create, :update]
  root :to => 'apps#index'

  get 'current_iteration' => 'iterations#current_iteration', :as => 'current_iteration'
  get 'get_customer_feedback' => 'iterations#get_customer_feedback', :as => 'get_customer_feedback'
  get 'feedback/:engagement_id/:iteration_id' => 'pending_feedback#form', :as => 'feedback_form'
  post 'feedback/:engagement_id/:iteration_id' => 'pending_feedback#process_response', :as => 'feedback_process_response'
end
