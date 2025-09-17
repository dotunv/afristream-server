# frozen_string_literal: true

module Auth
  class UsersController < ApplicationController
    protect_from_forgery with: :null_session

    def register
      user_params = params.permit(:email, :password, :password_confirmation, :role, :phone_number, :phone_country)
      user = User.new(user_params)
      user.role ||= :fan
      if user.save
        render json: { ok: true, user: { id: user.id, email: user.email, role: user.role } }, status: :created
      else
        render json: { ok: false, errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def login
      # Devise-jwt will add Authorization header on successful sign in
      user = nil
      if params[:email].present?
        user = User.find_for_database_authentication(email: params[:email])
      elsif params[:phone].present?
        # Accept E.164 or raw phone with optional country; rely on DB normalized phone_e164
        phone = params[:phone]
        if phone.start_with?('+')
          user = User.find_by(phone_e164: phone)
        else
          # Try to parse with optional country param
          country = params[:phone_country]
          parsed = Phonelib.parse(phone, country.presence)
          user = User.find_by(phone_e164: parsed.e164) if parsed.valid?
        end
      end

      if user&.valid_password?(params[:password])
        sign_in(user)
        render json: { ok: true, user: { id: user.id, email: user.email, role: user.role } }
      else
        render json: { ok: false, error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    def logout
      # Devise-jwt will revoke token on sign out when mapped in devise initializer
      if current_user
        sign_out(current_user)
      end
      head :no_content
    end

    def whoami
      if current_user
        render json: { id: current_user.id, email: current_user.email, role: current_user.role, phone_e164: current_user.phone_e164 }
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
