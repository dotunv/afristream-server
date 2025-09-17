# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Auth API', type: :request do
  path '/auth/register' do
    post 'Register a new user' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          role: { type: :string, enum: %w[fan creator admin] },
          phone_number: { type: :string },
          phone_country: { type: :string }
        },
        required: %w[password password_confirmation]
      }

      response '201', 'created' do
        let(:payload) do
          {
            email: 'user@example.com',
            password: 'secret123',
            password_confirmation: 'secret123',
            role: 'fan'
          }
        end
        run_test!
      end

      response '422', 'invalid' do
        let(:payload) do
          {
            password: 'short',
            password_confirmation: 'mismatch'
          }
        end
        run_test!
      end
    end
  end

  path '/auth/login' do
    post 'Login (email or phone)' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          phone: { type: :string },
          phone_country: { type: :string },
          password: { type: :string }
        },
        required: %w[password]
      }

      response '200', 'ok' do
        let!(:user) { User.create!(email: 'user2@example.com', password: 'secret123', password_confirmation: 'secret123') }
        let(:payload) { { email: 'user2@example.com', password: 'secret123' } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:payload) { { email: 'user2@example.com', password: 'wrong' } }
        run_test!
      end
    end
  end
end
