Rails.application.routes.draw do
  # API routes are in /api namespace
  namespace :api, defaults: { format: 'json' } do
    # /api/events
    resource :events do
      get 'list'
      post 'create'
    end
    
    resource :attendees do
      post 'create_form_record_if_attendee_exists'
    end
  end

  # Use React to handle all routes outside of API
  root to: 'static#index'
  get '*path' => 'static#index'
end
