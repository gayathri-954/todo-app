# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if running in production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

# Load all support files (custom matchers, macros, helpers)
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

# Ensure test database schema is up to date
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Path for fixtures
  config.fixture_path = Rails.root.join('spec/fixtures')

  # Use transactional fixtures to keep test DB clean
  config.use_transactional_fixtures = true

  # Infer test type from file location (models, controllers, requests, etc.)
  config.infer_spec_type_from_file_location!

  # Filter Rails gems from backtraces
  config.filter_rails_from_backtrace!

  # Include FactoryBot methods (so you can use `create` instead of `FactoryBot.create`)
  config.include FactoryBot::Syntax::Methods

  # Optional: include helpers for Devise/Devise Token Auth
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers

  # Reset Warden after each test (for authentication tests)
  config.after(type: :controller) { Warden.test_reset! }
end
