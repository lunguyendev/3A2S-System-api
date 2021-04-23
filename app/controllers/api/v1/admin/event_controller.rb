# frozen_string_literal: true

class Api::V1::Admin::EventController < AdminController
  def approve_event
    unless target_event.pending?
      return render json: { message: I18n.t("message_response.event_updated") }, status: :bad_request
    end

    target_event.accept!
    head :accepted
  end

  def cancel_event
    unless target_event.pending?
      return render json: { message: I18n.t("message_response.event_updated") }, status: :bad_request
    end

    target_event.cancel!
    head :accepted
  end

  private
    def target_event
      Event.find(params[:event_uid])
    end
end
