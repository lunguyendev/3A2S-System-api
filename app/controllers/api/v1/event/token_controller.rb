# frozen_string_literal: true

class Api::V1::Event::TokenController < ApplicationController
  def qr_code
    qr_code = Token.find_by!(qr_code_id: params[:event_uid])

    render json: {
      qr_code: qr_code.qr_code_string
    }, status: :ok
  end
end
