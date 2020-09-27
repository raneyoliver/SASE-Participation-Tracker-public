# Load the Rails application.
require_relative 'application'

# Setup capybara if it's being used
begin
  require 'capybara'
  # Use javascript driver for Capybara
  Capybara.configure do |config|
    config.default_driver = :selenium
    config.default_max_wait_time = 5
  end
rescue LoadError
end

# Initialize the Rails application.
Rails.application.initialize!

# Ruby makes table names plural by default, which goes against convention
ActiveRecord::Base.pluralize_table_names = false


# Uncomment this to see the page after cucumber finishes running
# (eg. to test the page state after tests fail)
#
# Selenium::WebDriver::Driver.class_eval do
#   def quit; end
# end
