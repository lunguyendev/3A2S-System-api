# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user, foreign_key: :user_uid, primary_key: :uid
  enum status: %i(pending cancel accept)
end
