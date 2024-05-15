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
        patch 'profile/update', to: 'api/v1/agents#update_agent'
        patch 'accept/:id', to: 'api/v1/agents#accept_task'
        patch 'remove/:id', to: 'api/v1/agents#remove_task'
        get 'own/mysupervisors', to: 'api/v1/agents#my_supervisors'
      end

      # Supervisors routes
      resources :supervisors, only: [] do
        get 'profile', to: 'api/v1/supervisors#profile', on: :collection
        patch 'profile/update', to: 'api/v1/supervisors#update_supervisor', on: :collection
      end

      # Customers routes
      resources :customers, only: [] do
        get 'profile', to: 'api/v1/customers#profile', on: :collection
        patch 'profile/update', to: 'api/v1/customers#update_customer', on: :collection
      end

      # Supervision routes
      post 'supervision/add', to: 'api/v1/supervisions#create'

      #follow routes for the supervision and the agen
      resources :supervision, only: [] do
        post '/:id/add', to: 'api/v1/fsupervisor#add', on: :collection
        post '/:id/remove', to: 'api/v1/fsupervisor#remove', on: :collection
        get '/count', to: 'api/v1/fsupervisor#add_count', on: :collection
        get '/:id/is_added', to: 'api/v1/fsupervisor#added?', on: :collection
        get '/under_supervision', to: 'api/v1/fsupervisor#under_supervision', on: :collection

      end

      #followability routes for supervisor
      # resources :sprofiles, only: [] do
      #   post '/:id/follow', to: 'api/v1/sprofile#follow', as: 'follow', on: :collection
      #   post '/:id/unfollow', to: 'api/v1/sprofile#unfollow', as: 'unfollow', on: :collection
      #   post '/:id/accept', to: 'api/v1/sprofile#accept', as: 'accept', on: :collection
      #   post '/:id/decline', to: 'api/v1/sprofile#decline', as: 'decline', on: :collection
      #   post '/:id/cancel', to: 'api/v1/sprofile#cancel', as: 'cancel', on: :collection
      #   get 'followers', to: 'api/v1/sprofile#show_followers', as: 'show_friends', on: :collection
      #   get 'pending', to: 'api/v1/sprofile#pending', as: 'pending', on: :collection
      #   get 'follow_requests', to: 'api/v1/sprofile#follow_requests', as: 'requests', on: :collection
      # end

      #followability routes for agent
      # resources :aprofiles, only: [] do
      #   post '/:id/follow', to: 'api/v1/aprofile#follow', as: 'follow', on: :collection
      #   post '/:id/unfollow', to: 'api/v1/aprofile#unfollow', as: 'unfollow', on: :collection
      #   post '/:id/accept', to: 'api/v1/aprofile#accept', as: 'accept', on: :collection
      #   post '/:id/decline', to: 'api/v1/aprofile#decline', as: 'decline', on: :collection
      #   post '/:id/cancel', to: 'api/v1/aprofile#cancel', as: 'cancel', on: :collection
      #   get 'followers', to: 'api/v1/aprofile#show_followers', as: 'show_friends', on: :collection
      #   get 'pending', to: 'api/v1/aprofile#pending', as: 'pending', on: :collection
      #   get 'follow_requests', to: 'api/v1/aprofile#follow_requests', as: 'requests', on: :collection
      # end



      # Task routes
      resources :tasks, only: [] do
        post 'create', to: 'api/v1/supervisors#create_task', on: :collection
        delete 'delete', to: 'api/v1/supervisors#delete_task', on: :collection
        patch 'update/:id', to: 'api/v1/supervisors#update_task', on: :collection
      end
    end
  end
end
