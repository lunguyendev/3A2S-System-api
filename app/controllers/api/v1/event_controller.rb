# frozen_string_literal: true

class Api::V1::EventController < ApplicationController
  def index
    event = Api::Event::FilterEvent.new(
      { type: params[:type] }
    ).execute

    @collection_event = Kaminari.paginate_array(event).page(params[:page]).per(10)

    event_serializable = ActiveModelSerializers::SerializableResource.new(
      @collection_event,
      each_serializer: Api::V1::EventSerializer
    )

    response_hash = {
      data: event_serializable,
      total_page: @collection_event.total_pages,
      current_page: @collection_event.current_page,
      total_count: event.count
    }

    render json: response_hash
  end

  def create
    event = @current_user.events.create(params_event_create)

    render json: event, serializer: Api::V1::EventSerializer
  end

  def show
    event = Event.find(params[:uid])

    render json: event, serializer: Api::V1::EventSerializer
  end

  def join_event
    Api::Event::JoinEvent.new(
      event_uid: params[:uid],
      user_uid: @current_user.uid
    ).execute

    head :created
  end

  private
    def params_event_create
      params.require(:event).permit(
        :type_event,
        :size,
        :organization,
        :description,
        :status,
        :start_at,
        :end_at
      )
    end
end
