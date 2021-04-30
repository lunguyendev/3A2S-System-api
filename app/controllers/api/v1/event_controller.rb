# frozen_string_literal: true

class Api::V1::EventController < ApplicationController
  def index
    event = Api::Event::FilterEvent.new(
      { type: params[:type] }
    ).execute

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

  def show
    event = Event.find(params[:uid])

    render json: event, serializer: Api::V1::EventSerializer, current_user: @current_user
  end
end
