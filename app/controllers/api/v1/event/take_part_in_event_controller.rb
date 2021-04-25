# frozen_string_literal: true

class Api::V1::Event::TakePartInEventController < ApplicationController
  def create
    Api::Event::JoinerEvent.new(
      event_uid: params[:event_uid],
      user_uid: @current_user.uid
    ).execute

    head :created
  end

  def list_attendance
    event = target_event
    list_user = User.users_by_ids(event.take_part_in_events.pluck(:user_uid))

    users_serializable = ActiveModelSerializers::SerializableResource.new(
      list_user,
      each_serializer: Api::V1::User::ListAttendanceSerializer,
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
