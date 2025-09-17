# frozen_string_literal: true

class SubtitlesController < ApplicationController
  protect_from_forgery with: :null_session

  # GET /subtitles/:id?lang=fr
  def show
    content = Content.find_by(id: params[:id])
    return render json: { error: 'Content not found' }, status: :not_found unless content

    lang = params[:lang]
    lang ||= request.headers['Accept-Language']&.slice(0, 2)
    lang ||= 'en'

    subtitle_blob = nil

    if content.translated_subtitles.attached?
      subtitle_blob = content.translated_subtitles.find do |att|
        att.filename.to_s.include?("#{lang}.srt") || att.filename.to_s.include?("_#{lang}") || att.filename.to_s.include?("-#{lang}")
      end
    end

    subtitle_blob ||= content.original_subtitle if content.original_subtitle.attached?

    unless subtitle_blob
      return render json: { error: 'No subtitles available' }, status: :not_found
    end

    redirect_to subtitle_blob.service_url(expires_in: 5.minutes)
  end
end
