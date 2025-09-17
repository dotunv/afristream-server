# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Creator API', type: :request do
  path '/creator/upload' do
    post 'Upload content (creator/admin)' do
      tags 'Creator'
      consumes 'multipart/form-data'

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end
