# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user, foreign_key: :user_uid, primary_key: :uid
  has_many :take_part_in_events, foreign_key: :event_uid, primary_key: :uid
  has_one :token, as: :qr_code
  enum status: %i(pending cancel accept)

  scope :created_at_desc, -> { order created_at: :desc }
  scope :organized, -> { where("end_at < ?", DateTime.now) }
  scope :organizing, -> { where("end_at >= ?", DateTime.now) }
end
