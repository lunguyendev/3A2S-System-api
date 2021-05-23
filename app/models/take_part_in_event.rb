# frozen_string_literal: true

class TakePartInEvent < ApplicationRecord
  belongs_to :user, foreign_key: :user_uid, primary_key: :uid
  belongs_to :event, foreign_key: :event_uid, primary_key: :uid

  enum status: %i(absent presence cancel)
end
