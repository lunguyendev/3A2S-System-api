# frozen_string_literal: true

class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes \
    :email,
    :type
end
