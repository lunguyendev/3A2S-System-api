# frozen_string_literal: true

class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes \
    :uid,
    :email,
    :name,
    :type,
    :avatar,
    :phone,
    :gender,
    :birthday,
    :class_activity,
    :id_student,
    :id_lecturer
end
