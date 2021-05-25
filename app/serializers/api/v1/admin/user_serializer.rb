# frozen_string_literal: true

class Api::V1::Admin::UserSerializer < ActiveModel::Serializer
  attributes \
    :uid,
    :name,
    :email,
    :type,
    :status,
    :gender,
    :phone,
    :class_activity,
    :id_student,
    :id_lecturer,
    :role,
    :avatar
end
