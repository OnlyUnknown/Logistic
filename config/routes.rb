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

  get 'agent/mytaskslist', to: 'api/v1/agents#mytasks_list'
      get 'agent/:id', to: 'api/v1/agents#index'
      get 'supervisor/:id', to: 'api/v1/supervisors#index'
      get 'customer/:id', to: 'api/v1/customers#index'
      post 'supervision/add', to: 'api/v1/supervisions#create'
      post 'task/create', to: 'api/v1/supervisors#create_task'
      delete 'task/delete', to: 'api/v1/supervisors#delete_task'
      patch 'task/update/:id', to: 'api/v1/supervisors#update_task'
      patch 'agent/accept/:id', to: 'api/v1/agents#accept_task'
      patch 'agent/remove/:id', to: 'api/v1/agents#remove_task'
      get 'agent/own/mysupervisors', to: 'api/v1/agents#my_supervisors'
    end
  end
end
