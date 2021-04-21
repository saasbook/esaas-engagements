Rails.application.routes.draw do

  # Notice order
  get '/matching/new' => 'matching#new', :as => "new_matching"
  post '/matching/create' => 'matching#create'
  get "/matching" => 'matching#index'
  get '/matching/:matching_id/engagement/:engagement_id' => 'matching#show', :as => "show_engagement_matching"
  get "/matching/:matching_id/progress" => 'matching#progress', :as => "matching_progress"
  
  post "/matching/:matching_id/engagement/:engagement_id/store" => 'matching#store'
  delete '/matching/:matching_id' => 'matching#destroy', :as => "delete_matching"

  # OmniAuth authentication with GitHub
  get 'login' => 'session#login', :as => 'login'
  match  'auth/:provider/callback' => 'session#create', :via => [:get, :post]
  get 'auth/failure' => 'session#failure'
  get 'logout' => 'session#destroy'

  # route /apps/:app_id/engagements/:engagement_id
  resources :apps do
    resources :engagements, :except => :index
    resources :comments, :only => [:create, :update], module: :apps
  end
  # route /engagements/:engagement_id/iterations/:iteration_id
  resources :engagements, :only => [] do # don't route engagements by themselves
    resources :iterations
  end

  get 'orgs/import' => 'orgs#import'

  resources :orgs do
    resources :comments, :only => [:create, :update], module: :orgs
    collection {post :import}
  end
  resources :comments, :only => [:edit, :destroy]

  get 'users/import' => 'users#import'

  resources :users do
    resources :comments, only: [:create, :update], module: :users
    collection {post :import}
  end

  # my_projects routes
  get 'my_projects' => 'my_projects#index',
      as: :my_projects
  get 'my_project_edit/:app_id/edit' => 'my_projects#edit',
      as: :edit_my_project_edit
  get 'my_project_edit/:app_id/new' => 'my_projects#new',
      as: :new_my_project_edit
  match 'my_project_edit/:app_id' => 'my_projects#create',
        via: [:post], as: :create_my_project_edit
  match 'my_project_edit/:app_id' => 'my_projects#update',
        via: [:put, :patch], as: :update_my_project_edit
  match 'my_project_edit/:app_id' => 'my_projects#destroy',
        via: [:delete], as: :delete_my_project_edit

  # my_approval_request routes
  get 'my_approval_requests' => 'my_approval_requests#index',
      as: :my_approval_requests
  get 'my_approval_requests/:app_id' => 'my_approval_requests#show',
      as: :show_my_approval_request
  match 'my_approval_requests/:app_id' => 'my_approval_requests#update',
        via: [:put, :patch], as: :approve_my_approval_requests

  root :to => 'apps#index'

  get 'myprojects/:id/edit/submit' => 'myprojects#view_submit', :as => 'view_submit'

  get 'current_iteration' => 'iterations#current_iteration', :as => 'current_iteration'
  get 'get_customer_feedback' => 'iterations#get_customer_feedback', :as => 'get_customer_feedback'
  get 'feedback/:engagement_id/:iteration_id' => 'pending_feedback#form', :as => 'feedback_form'
  post 'feedback/:engagement_id/:iteration_id' => 'pending_feedback#process_response', :as => 'feedback_process_response'
  post 'search' => 'search#search', :as => 'search'
  get 'results' => 'search#results', :as => 'results'
  get 'public_search' => 'search#public_search', :as => 'public_search'


  get 'creation' => 'creation#new', :as => 'creation'
  post 'creation' => 'creation#create', :as => 'create_all'

  get '/apps/:app_id/engagements/:id/export' => 'engagements#export', :as => 'export'

  get 'mail_all_orgs' => 'orgs#mail_all_orgs_form', :as => 'mail_all_orgs_form'
  post 'mail_all_orgs' => 'orgs#mail_all_orgs', :as => 'mail_all_orgs'

end
