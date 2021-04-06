# frozen_string_literal: true

class Api::V1::Event::TokenController < ApplicationController
  def create
    return head :unauthorized unless check_creator_event?

    qr_code = Api::Event::CreatorQrEvent.new(
      object: target_event,
      expired_time: params[:expired_time]
    ).execute

    render json: {
      qr_code: qr_code.qr_code_string
    }, status: :created
  end

  def qr_code
    qr_code = Token.find_by!(qr_code_id: params[:event_uid])

    render json: {
      qr_code: qr_code.qr_code_string
    }, status: :ok
  end

  private
    def check_creator_event?
      return true if target_event.user_uid === @current_user.uid

      false
    end

    def target_event
      @event ||= Event.accept.find_by!(uid: params[:event_uid])
    end
end
