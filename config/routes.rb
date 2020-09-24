Rails.application.routes.draw do
  # API routes are in /api namespace
  namespace :api, defaults: { format: 'json' } do
    # /api/events
    resource :events do
      get 'list'
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
  root to: 'static#index'
  get '*path' => 'static#index'
end
