# frozen_string_literal: true

class LicensesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  # POST /licenses
  # Params: content_id, device_id
  def create
    content = Content.find_by(id: params[:content_id])
    return render json: { error: 'Content not found' }, status: :not_found unless content

    # Ensure user has purchased content
    purchased = current_user.transactions.where(content_id: content.id, status: :success).exists?
    return render json: { error: 'Forbidden' }, status: :forbidden unless purchased || current_user.admin?

    license = License.find_or_initialize_by(user: current_user, content: content, device_id: params[:device_id] || 'web')
    if license.new_record?
      license.license_token = SecureRandom.hex(16)
      license.expires_at = 30.days.from_now
    else
      # refresh expiry on re-issue
      license.expires_at = 30.days.from_now
    end

    if license.save
      render json: { ok: true, license: { token: license.license_token, expires_at: license.expires_at } }, status: :created
    else
      render json: { ok: false, errors: license.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /licenses/:id
  def show
    license = License.find_by(id: params[:id])
    return render json: { error: 'Not found' }, status: :not_found unless license
    return render json: { error: 'Forbidden' }, status: :forbidden unless license.user_id == current_user.id || current_user.admin?

    render json: { ok: true, license: { id: license.id, token: license.license_token, expires_at: license.expires_at, content_id: license.content_id, device_id: license.device_id } }
  end
end
