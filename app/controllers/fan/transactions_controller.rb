# frozen_string_literal: true

module Fan
  class TransactionsController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      render json: { ok: true, action: 'fan#transactions#create', content_id: params[:id] }
    end

    def library
      render json: { ok: true, action: 'fan#transactions#library', items: [] }
    end
  end
end
