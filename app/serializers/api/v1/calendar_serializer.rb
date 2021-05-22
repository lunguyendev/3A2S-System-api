# frozen_string_literal: true

class Api::V1::CalendarSerializer < ActiveModel::Serializer
  attributes :id_calendar

  attribute :meeting_url

  def meeting_url
    object.meet_url || false
  end
end
