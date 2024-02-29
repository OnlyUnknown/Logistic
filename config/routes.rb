Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope :api do
    scope :v1 do
      mount_devise_token_auth_for 'Agent', at: 'agent'
      get 'agent/:id', to: 'agents#index'
      get 'supervisor/:id', to: 'supervisors#index'
      get 'customer/:id', to: 'customers#index'
      post 'supervision/add', to: 'supervisions#create'
    end
  end
end
