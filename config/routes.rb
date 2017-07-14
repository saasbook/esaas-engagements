Rails.application.routes.draw do
  resources :apps do
    resources :engagements, :except => :index
  end
  resources :orgs
  resources :users
  root :to => 'apps#index'
end
