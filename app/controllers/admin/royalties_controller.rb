# frozen_string_literal: true

module Admin
  class RoyaltiesController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :authenticate_user!
    before_action :ensure_admin!

    def index
      data = Royalty.includes(:creator, :content)
                    .group(:creator_id)
                    .sum(:amount_cents)

      creators = User.where(id: data.keys).index_by(&:id)

      result = data.map do |creator_id, cents|
        {
          creator_id: creator_id,
          creator_email: creators[creator_id]&.email,
          amount_cents: cents
        }
      end

      render json: { ok: true, royalties: result }
    end

    private

    def ensure_admin!
      render json: { error: 'Forbidden' }, status: :forbidden unless current_user&.admin?
    end
  end
end
