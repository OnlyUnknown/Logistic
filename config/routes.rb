Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get 'agent/:id', to: 'agents#index'
      get 'supervisor/:id', to: 'supervisors#index'
      get 'customer/:id', to: 'customers#index'
    end
  end
end
