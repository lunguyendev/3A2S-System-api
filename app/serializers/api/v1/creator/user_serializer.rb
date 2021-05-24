# frozen_string_literal: true

class Api::V1::Creator::UserSerializer < ActiveModel::Serializer
  attributes \
    :email
end
