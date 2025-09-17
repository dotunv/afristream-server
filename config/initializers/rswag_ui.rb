# frozen_string_literal: true

Rswag::Ui.configure do |c|
  # List the Swagger endpoints that you want to be documented through the
  # swagger-ui. The first parameter is the path (absolute or relative to the UI
  # host) to the corresponding endpoint and the second is a title that will be
  # displayed in the document selector.
  c.openapi_endpoint '/api-docs/v1/swagger.yaml', 'AfriStream API V1'

  # Add Basic Auth in production if needed:
  # c.basic_auth_enabled = true
  # c.basic_auth_credentials 'username', 'password'
end
