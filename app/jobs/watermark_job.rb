# frozen_string_literal: true

class WatermarkJob < ApplicationJob
  queue_as :default

  # Add a visible watermark to the uploaded video using ffmpeg
  # Params: content_id
  def perform(content_id)
    content = Content.find_by(id: content_id)
    return unless content&.file&.attached?

    # TODO: download file, run ffmpeg to burn watermark (e.g., user email/phone), re-attach
    Rails.logger.info("[WatermarkJob] Watermarking content ##{content.id}")
  end
end
