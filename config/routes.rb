Rails.application.routes.draw do
  # API routes are in /api namespace
  namespace :api, defaults: { format: 'json' } do
    # /api/events
    resource :events do
      get 'list'
      post 'create'
      get 'export'
      post 'add_form'
      get ':id', to: 'events#edit'
      post 'update'
      post 'delete'
    end

    devise_for :admins, controllers: {
      registrations: 'api/registrations',
      sessions: 'api/sessions',
    }

    # /api/form_users
    resource :form_users do
      post 'create'
    end

    # /api/users
    resource :users do
      post 'handle_identification'
      post 'create'
    end

    # /api/forms
    resource :forms do
      get ':id', to: 'forms#show'
    end
  end

  # Use React to handle all routes outside of API

  # Route that allows heroku to properly find index.js
  get 'index.js' => 'static#index_js'

  # If for some reason somebody goes back to login while still logged in this redirects them
  get 'login' => 'static#login'

  get '/' => 'static#view_events'

  # These routes should not be accessible without authenticating through the login page
  get 'create_event' => 'static#authorized_index'
  get 'change_password' => 'static#authorized_index'
  get 'edit_event' => 'static#authorized_index'

  root to: 'static#index'
  get '*path' => 'static#index'
end
