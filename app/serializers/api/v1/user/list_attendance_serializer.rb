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
end
