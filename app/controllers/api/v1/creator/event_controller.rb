# frozen_string_literal: true

class Api::V1::Creator::EventController < CreatorController
  def create
    @current_user.events.create(params_event_create)

    head :created
  end

  def index
    event = Api::Event::Management::FilterEvent.new(
      {
        type: params[:type],
        user_management: @current_user
      }
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

  private
    def params_event_create
      params.require(:event).permit(
        :name,
        :type_event,
        :size,
        :organization,
        :description,
        :location,
        :status,
        :start_at,
        :end_at
      )
    end
end
