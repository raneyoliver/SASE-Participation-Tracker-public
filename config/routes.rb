Rails.application.routes.draw do
  # API routes are in /api namespace
  namespace :api, defaults: { format: 'json' } do
    # /api/events
    resource :events do
      get 'list'
      get 'last'
      post 'create'
    end

    # /api/form
    resource :forms do
      get 'list'
      post 'create'
    end

  end
  
  # Use React to handle all routes outside of API
  root to: 'static#index'
  get '*path' => 'static#index'
end
