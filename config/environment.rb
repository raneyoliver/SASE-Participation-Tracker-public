# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Ruby makes table names plural by default, which goes against convention
ActiveRecord::Base.pluralize_table_names = false
