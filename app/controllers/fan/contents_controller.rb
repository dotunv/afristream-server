# frozen_string_literal: true

module Fan
  class ContentsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render json: { ok: true, action: 'fan#contents#index', items: [] }
    end
  end
end
