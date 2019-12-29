# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :tickets do
    post :replies, to: 'replies#create'
  end

  delete 'replies/:id', to: 'replies#destroy', as: :replies
  resources :users
  root to: 'tickets#index'
end
