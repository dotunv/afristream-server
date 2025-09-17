# frozen_string_literal: true

# This file is used by rswag to configure the swagger generation from specs.
# Run with: bundle exec rake rswag:specs:swaggerize

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.3',
      info: {
        title: 'AfriStream API',
        version: 'v1'
      },
      servers: [
        { url: 'http://localhost:3000' }
      ],
      components: {
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'JWT'
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  config.swagger_format = :yaml
end
