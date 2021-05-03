# frozen_string_literal: true

class Api::V1::Creator::Event::TakePartInEventController < CreatorController
  def list_attendance
    event = target_event
    list_user = User.users_by_ids(event.take_part_in_events.pluck(:user_uid))

    users_serializable = ActiveModelSerializers::SerializableResource.new(
      list_user,
      each_serializer: Api::V1::User::ListAttendanceSerializer,
      event:  event.uid
    )
    response_hash = {
      data: users_serializable,
      event: {
        event_uid: event.uid,
        event_name: event.event_name
      }
    }

    render json: response_hash
  end

  private
    def target_event
      Event.find(params[:event_uid])
    end
end
