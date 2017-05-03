Rails.application.routes.draw do
  resources :engagements
  resources :apps
  resources :orgs
  resources :users
  root :to => 'apps#index'
end
