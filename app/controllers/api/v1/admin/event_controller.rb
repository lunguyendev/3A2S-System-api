# frozen_string_literal: true

class Api::V1::Admin::EventController < AdminController
  def my_event
    event = @current_user.events.order("created_at DESC")

    @collection_event = Kaminari.paginate_array(event).page(params[:page]).per(10)

    event_serializable = ActiveModelSerializers::SerializableResource.new(
      @collection_event,
      each_serializer: Api::V1::EventSerializer,
      current_user: @current_user
    )

    response_hash = {
      data: event_serializable,
      total_page: @collection_event.total_pages,
      current_page: @collection_event.current_page,
      total_count: event.count
    }

    render json: response_hash
  end

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

    target_event.update_attributes!(
      handel_by: @current_user.name
    )
    target_event.cancel!
    target_event.update(cancel_param)

    head :accepted
  end

  def event_statistics
    number = Event.count_events_by_day(date_param[:start_at], date_param[:end_at])
    number_hash = number.map do |k, v|
      { k.to_date => v }
    end
    render json: number_hash, status: :ok
  end

  def event_statistics_by_year
    data = Api::Event::Statistics::Admin.new(year_param[:year]).execute
    render json: data, status: :ok
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

    def year_param
      params.permit(:year)
    end

    def cancel_param
      params.permit(:note)
    end
end
