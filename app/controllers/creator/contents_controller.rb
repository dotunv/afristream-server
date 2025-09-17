# frozen_string_literal: true

module Creator
  class ContentsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :authenticate_user!
    before_action :ensure_creator!

    def create
      content_params = params.permit(:title, :description, :price_cents, :file)
      content = current_user.contents.build(
        title: content_params[:title],
        description: content_params[:description],
        price_cents: content_params[:price_cents]
      )

      if content_params[:file].present?
        content.file.attach(content_params[:file])
      end

      if content.save
        # Enqueue background processing
        WatermarkJob.perform_later(content.id)
        EncryptJob.perform_later(content.id)
        GenerateSubtitlesJob.perform_later(content.id)

        render json: {
          ok: true,
          content: {
            id: content.id,
            title: content.title,
            price_cents: content.price_cents,
            creator_id: content.creator_id
          }
        }, status: :created
      else
        render json: { ok: false, errors: content.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def dashboard
      render json: { ok: true, action: 'creator#contents#dashboard', stats: { views: 0, earnings: 0 } }
    end

    private

    def ensure_creator!
      unless current_user&.creator? || current_user&.admin?
        render json: { error: 'Forbidden' }, status: :forbidden
      end
    end
  end
end
