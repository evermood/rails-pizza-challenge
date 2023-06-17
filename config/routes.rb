# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders, only: %i[index update]

  root 'orders#index'
end
