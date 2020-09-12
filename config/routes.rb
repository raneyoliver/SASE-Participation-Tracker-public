Rails.application.routes.draw do
  # API routes are in /api namespace
  namespace :api, defaults: { format: "json" } do
  end

  # Use React to handle all routes outside of API
  root to: "static#index"
  get "*path" => "static#index"
end
