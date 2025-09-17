# frozen_string_literal: true

class GenerateSubtitlesJob < ApplicationJob
  queue_as :default

  # Generate original-language subtitles using Whisper
  # Params: content_id
  def perform(content_id)
    content = Content.find_by(id: content_id)
    return unless content&.file&.attached?

    Rails.logger.info("[GenerateSubtitlesJob] Generating subtitles for content ##{content.id}")
    # TODO: extract audio via ffmpeg, call Whisper, attach .srt to original_subtitle
  end
end
