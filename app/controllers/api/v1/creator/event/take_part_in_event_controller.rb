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

  def attendance
    raise Errors::ExceptionHandler::InvalidAction if take_part_in_event&.presence?

    unless @attendance = take_part_in_event.presence
      @attendance = Api::Event::JoinerEvent.new(
        event_uid: target_event.uid,
        user_uid: target_user.uid
      ).execute
    end

    @attendance.presence!
    head :created
  end

  private
    def take_part_in_event
      @attendance = target_event.take_part_in_events.find_by(user_uid: target_user)
    end

    def target_event
      @event ||= Event.find(params[:event_uid])
    end

    def target_user
      @user ||= User.find_by(email: params[:email])

      raise Errors::ExceptionHandler::InvalidAction unless @user.present?
      @user
    end
end
