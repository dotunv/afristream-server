# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Fan API', type: :request do
  path '/fan/purchase/{id}' do
    post 'Purchase content (mock) and issue license' do
      tags 'Fan'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true

      response '401', 'unauthorized' do
        let(:id) { 1 }
        run_test!
      end
    end
  end

  path '/fan/library' do
    get 'List purchased content for current user' do
      tags 'Fan'

      response '401', 'unauthorized' do
        run_test!
      end
    end
  end
end
