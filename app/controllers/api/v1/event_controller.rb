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
    Api::Event::JoinerEvent.new(
      event_uid: params[:uid],
      user_uid: @current_user.uid
    ).execute

    head :created
  end

  def generate_qr_code
    qr_code = Api::Event::CreatorQrEvent.new(
      object: target_event,
      expired_time: params[:expired_time]
    ).execute

    render json: {
      qr_code: qr_code.qr_code_string
    }, status: :created
  end

  def qr_code
    qr_code = Token.find_by!(qr_code_id: params[:uid])

    render json: {
      qr_code: qr_code.qr_code_string
    }, status: :ok
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

    def target_event
      Event.find(params[:uid])
    end
end
