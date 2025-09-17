# frozen_string_literal: true

module Auth
  class UsersController < ApplicationController
    protect_from_forgery with: :null_session

    def register
      user_params = params.permit(:email, :password, :password_confirmation, :role)
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
      user = User.find_for_database_authentication(email: params[:email])
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
  end
end
