Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope :api do
    scope :v1 do
      devise_for :agents, path: 'agents', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/agents/sessions',
    registrations: 'api/v1/agents/registrations'
  }
  devise_for :supervisors, path: 'supervisors', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/supervisors/sessions',
    registrations: 'api/v1/supervisors/registrations'
  }
  devise_for :customers, path: 'customers', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'api/v1/customers/sessions',
    registrations: 'api/v1/customers/registrations'
  }
  
      get 'agent/:id', to: 'agents#index'
      get 'supervisor/:id', to: 'supervisors#index'
      get 'customer/:id', to: 'customers#index'
      post 'supervision/add', to: 'supervisions#create'
    end
  end
end
