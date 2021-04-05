# frozen_string_literal: true

class Api::V1::TokensController < ApplicationController
  def attendace_by_qr_code
    event_uid = target_token.qr_code_id

    Api::Event::Attendance.new(
      event: event_uid,
      user: @current_user.uid
    ).execute

    head :ok
  end

  private
    def target_token
      Token.find_by!(qr_code_string: params[:token_string])
    end
end
