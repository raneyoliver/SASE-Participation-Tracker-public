Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'api/users/registrations',
    sessions: 'api/users/sessions'
  }
  # API routes are in /api namespace
  namespace :api, defaults: { format: 'json' } do
    # /api/events
    resource :events do
      get 'list'
      post 'create'
    end
  end

  # Use React to handle all routes outside of API
  root to: 'static#index'
  get '*path' => 'static#index'
end
