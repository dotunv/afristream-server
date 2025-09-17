# frozen_string_literal: true

# Configure CORS to allow mobile/web clients during development.
# Tighten origins in production.
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: %w[Authorization],
      max_age: 600
  end
end
