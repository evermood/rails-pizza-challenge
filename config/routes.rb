Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'orders#index'

  get 'orders', to: 'orders#index'
  patch '/orders/:id', to: 'orders#complete'
end
