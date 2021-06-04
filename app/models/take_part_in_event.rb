# frozen_string_literal: true

class TakePartInEvent < ApplicationRecord
  belongs_to :user, foreign_key: :user_uid, primary_key: :uid
  belongs_to :event, foreign_key: :event_uid, primary_key: :uid

  enum status: %i(absent presence cancel)
  scope :with_year_and_month, ->(year, month) {
    where(created_at: Date.new(year, month, 1)..Date.new(year, month, -1)).count
  }
  scope :attendance, ->(user_uid) { presence.where("user_uid = ? AND evaluated = true", user_uid) }
end
