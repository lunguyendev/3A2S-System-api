# frozen_string_literal: true

class Api::V1::Admin::EventController < AdminController
  def approve_event
    unless target_event.pending?
      return render json: { message: I18n.t("message_response.event_updated") }, status: :bad_request
    end

    target_event.update_attributes!(
      scope: approval_params[:scope],
      handel_by: @current_user.name
    )
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

  def event_statistics
    number = Event.count_events_by_day(date_param[:start_at], date_param[:end_at])
    number_hash = number.map do |k, v|
      { k.to_date => v }
    end
    render json: number_hash, status: :ok
  end

  private
    def target_event
      Event.find(params[:event_uid])
    end

    def approval_params
      params.require(:event).permit(:scope)
    end

    def date_param
      params.require(:date)
            .permit(:start_at, :end_at)
    end
end
