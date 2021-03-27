# frozen_string_literal: true

class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes \
    :uid,
    :type_event,
    :size,
    :organization,
    :description,
    :status,
    :start_at,
    :end_at

  belongs_to :user, serializer: Api::V1::UserSerializer
end
