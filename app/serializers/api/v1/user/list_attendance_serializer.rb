# frozen_string_literal: true

class Api::V1::User::ListAttendanceSerializer < ActiveModel::Serializer
  attributes \
    :uid,
    :name,
    :email,
    :phone,
    :gender,
    :birthday,
    :class_activity,
    :id_student

  attribute :is_attendance

  def initialize(object, options = {})
    @event = options[:event]
    super
  end

  def is_attendance
    return true if target_join_event.presence?

    false
  end

  def is_cancel
    return true if target_join_event.presence?

    false
  end

  def target_join_event
    TakePartInEvent.find_by(
      event_uid: @event,
      user_uid: object.uid
    )
  end
end
