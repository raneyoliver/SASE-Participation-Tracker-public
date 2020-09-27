Rails.application.routes.draw do
  # API routes are in /api namespace
  namespace :api, defaults: { format: 'json' } do
    # /api/events
    resource :events do
      get 'list'
      post 'create'
    end

    devise_scope :admin do
      post 'api/admins/sign_in' => 'devise/sessions#create'
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

  # These routes should not be accessible without authenticating through the login page
  get 'create_event' => 'static#authorized_index'

  # Use React to handle all routes outside of API
  root to: 'static#index'
  get '*path' => 'static#index'
end
