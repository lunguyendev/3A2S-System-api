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

    count_attendance = target_event.take_part_in_events.presence.count
    count_join = target_event.take_part_in_events.count
    count_cancel = target_event.take_part_in_events.cancel.count
    response_hash = {
      data: users_serializable,
      event: {
        event_uid: event.uid,
        event_name: event.event_name
      },
      count_attendance: count_attendance,
      count_join: count_join,
      count_cancel: count_cancel
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

  def export_list_attendance
    GoogleSheet::ExportListAttendance.new(
      {
        spreadsheet_key: spreadsheet_params[:spreadsheet_key],
        name_sheet: spreadsheet_params[:sheet_name],
        event: target_event
      }
    ).execute
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

    def spreadsheet_params
      params.require(:spreadsheet)
            .permit(:spreadsheet_key, :sheet_name)
    end
end
