# frozen_string_literal: true

module Creator
  class ContentsController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      render json: { ok: true, action: 'creator#contents#create' }
    end

    def dashboard
      render json: { ok: true, action: 'creator#contents#dashboard', stats: { views: 0, earnings: 0 } }
    end
  end
end
