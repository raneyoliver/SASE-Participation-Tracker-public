Rails.application.routes.draw do
  # API routes are in /api namespace
  namespace :api, defaults: { format: 'json' } do
    # /api/events
    resource :events do
      get 'list'
      post 'create'
    end
    devise_for :users, controllers: {
      registrations: 'api/registrations',
      sessions: 'api/sessions'
    }
  end

  # Use React to handle all routes outside of API
  root to: 'static#index'
  get '*path' => 'static#index'
end
