Rails.application.routes.draw do
  resources :tickets
  devise_for :users
  root to: 'tickets#index'
end
