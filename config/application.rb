require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ParticipationTracker
  # Performs init for rails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Webpack is used for compilation, disable compiling with sprockets
    config.assets.precompile = []
    config.assets.check_precompiled_asset = false

    # Ruby makes test files (not spec files) by default, which we don't need
    config.generators do |g|
      g.test_framework = 'rspec'
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
