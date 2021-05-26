# frozen_string_literal: true

class Api::V1::Creator::EventController < CreatorController
  def create
    event = @current_user.events.create(params_event_create)
    event.accept! if @current_user.admin? || @current_user.approval?
    GoogleCalendar::Create.new(event, @current_user).execute if params_event_create[:is_online]
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

  def generate_meeting
    event = Event.find(params[:uid])
    GoogleCalendar::CreateMeet.new(event.calendar.id_calendar).execute
    head :created
  end

  private
    def params_event_create
      params.require(:event).permit(
        :event_name,
        :avatar,
        :is_online,
        :size,
        :organization,
        :description,
        :location,
        :start_at,
        :end_at,
        type_event_uids: []
      )
    end
end
