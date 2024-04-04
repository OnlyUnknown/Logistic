Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      # Devise routes for agents
      devise_for :agents, path: 'agents', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      }, controllers: {
        sessions: 'api/v1/agents/sessions',
        registrations: 'api/v1/agents/registrations'
      }

      # Devise routes for supervisors
      devise_for :supervisors, path: 'supervisors', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      }, controllers: {
        sessions: 'api/v1/supervisors/sessions',
        registrations: 'api/v1/supervisors/registrations'
      }

      # Devise routes for customers
      devise_for :customers, path: 'customers', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      }, controllers: {
        sessions: 'api/v1/customers/sessions',
        registrations: 'api/v1/customers/registrations'
      }

      # Agents routes
      scope :agents do
        get 'mytaskslist', to: 'api/v1/agents#mytasks_list'
        get 'profile', to: 'api/v1/agents#profile'
        patch 'profile/update', to: 'api/v1/agents#profile'
        patch 'accept/:id', to: 'api/v1/agents#accept_task'
        patch 'remove/:id', to: 'api/v1/agents#remove_task'
        get 'own/mysupervisors', to: 'api/v1/agents#my_supervisors'
      end

      # Supervisors routes
      resources :supervisors, only: [] do
        get ':id', to: 'api/v1/supervisors#index', on: :collection
      end

      # Customers routes
      resources :customers, only: [] do
        get 'profile', to: 'api/v1/customers#profile', on: :collection
        patch 'profile/update', to: 'api/v1/customers#update_customer', on: :collection
      end

      # Supervision routes
      post 'supervision/add', to: 'api/v1/supervisions#create'

      # Task routes
      resources :tasks, only: [] do
        post 'create', to: 'api/v1/supervisors#create_task', on: :collection
        delete 'delete', to: 'api/v1/supervisors#delete_task', on: :collection
        patch 'update/:id', to: 'api/v1/supervisors#update_task', on: :collection
      end
    end
  end
end
