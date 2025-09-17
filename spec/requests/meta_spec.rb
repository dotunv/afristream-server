# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Meta API', type: :request do
  path '/meta/countries' do
    get 'List curated African countries' do
      tags 'Meta'
      produces 'application/json'

      response '200', 'ok' do
        run_test!
      end
    end
  end

  path '/meta/countries_with_codes' do
    get 'List countries with calling codes' do
      tags 'Meta'
      produces 'application/json'

      response '200', 'ok' do
        run_test!
      end
    end
  end

  path '/meta/phone_mask/{country}' do
    get 'Get a suggested phone mask for a country' do
      tags 'Meta'
      produces 'application/json'
      parameter name: :country, in: :path, type: :string, required: true, description: 'ISO2 country code (e.g., NG)'

      response '200', 'ok' do
        let(:country) { 'NG' }
        run_test!
      end
    end
  end
end
