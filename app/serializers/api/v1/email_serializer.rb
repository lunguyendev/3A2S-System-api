# frozen_string_literal: true

class Api::V1::EmailSerializer < ActiveModel::Serializer
  attributes \
    :uid,
    :title,
    :content,
    :list_email,
    :send_by
end
