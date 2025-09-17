# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Subtitles API', type: :request do
  path '/subtitles/{id}' do
    get 'Get subtitles (redirects to signed URL)' do
      tags 'Subtitles'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true
      parameter name: :lang, in: :query, type: :string, required: false

      response '404', 'not found' do
        let(:id) { 999_999 }
        run_test!
      end
    end
  end
end
