# frozen_string_literal: true

class EncryptJob < ApplicationJob
  queue_as :default

  # Encrypt the uploaded content file using AES; store CEK ciphertext via Lockbox
  # Params: content_id
  def perform(content_id)
    content = Content.find_by(id: content_id)
    return unless content&.file&.attached?

    Rails.logger.info("[EncryptJob] Encrypting content ##{content.id}")
    # TODO: generate CEK, encrypt with Lockbox, encrypt file bytes, re-attach
  end
end
