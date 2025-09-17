# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__ + '/..')
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'swagger_helper'
require 'devise'

# Requires supporting ruby files with custom matchers and macros, etc, in spec/support/ and its subdirectories.
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # Devise helpers for request specs
  config.include Devise::Test::IntegrationHelpers, type: :request

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
