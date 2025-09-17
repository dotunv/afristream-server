# frozen_string_literal: true

module Admin
  class RoyaltiesController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render json: { ok: true, action: 'admin#royalties#index', royalties: [] }
    end
  end
end
