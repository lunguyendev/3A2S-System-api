# frozen_string_literal: true

class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes \
    :uid,
    :is_rating,
    :content
end
