# frozen_string_literal: true

class SubtitlesController < ApplicationController
  protect_from_forgery with: :null_session

  # GET /subtitles/:id?lang=fr
  def show
    render json: { ok: true, action: 'subtitles#show', content_id: params[:id], lang: params[:lang] || 'en' }
  end
end
