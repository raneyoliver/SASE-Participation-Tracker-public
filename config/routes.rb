Rails.application.routes.draw do
  # API routes are in /api namespace
  namespace :api, defaults: { format: 'json' } do
    # /api/events
    resource :events do
      get 'list'
      post 'create'
    end

    resource :users do
      post 'create_form_record_if_user_exists'
      post 'create_user_and_form_record'
    end
  end

  # Use React to handle all routes outside of API
  root to: 'static#index'
  get '*path' => 'static#index'
end
