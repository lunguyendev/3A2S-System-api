# frozen_string_literal: true

class Calendar < ApplicationRecord
  belongs_to :event, foreign_key: :event_uid, primary_key: :uid

  scope :update_meet_url, ->(id_calendar, meet_url) { find_by(id_calendar: id_calendar).update(meet_url: meet_url) }
end
