# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :tickets
  resources :users
  root to: 'tickets#index'
end
