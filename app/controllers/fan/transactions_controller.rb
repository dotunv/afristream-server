# frozen_string_literal: true

module Fan
  class TransactionsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :authenticate_user!

    def create
      content = Content.find_by(id: params[:id])
      return render json: { ok: false, error: 'Content not found' }, status: :not_found unless content

      # Mock payment processing
      txn = Transaction.new(
        user: current_user,
        content: content,
        amount_cents: content.price_cents,
        status: :success,
        provider: 'mock',
        reference: SecureRandom.uuid
      )

      ActiveRecord::Base.transaction do
        txn.save!
        License.create!(
          user: current_user,
          content: content,
          device_id: params[:device_id] || 'web',
          license_token: SecureRandom.hex(16),
          expires_at: 30.days.from_now
        )
      end

      render json: { ok: true, transaction: { id: txn.id, status: txn.status, reference: txn.reference } }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { ok: false, error: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def library
      items = current_user.transactions.includes(:content).map do |t|
        {
          content_id: t.content_id,
          title: t.content.title,
          purchased_at: t.created_at
        }
      end
      render json: { ok: true, items: items }
    end
  end
end
