# frozen_string_literal: true

class User < ApplicationRecord
  has_many :events, foreign_key: :user_uid, primary_key: :uid
  has_many :take_part_in_events, foreign_key: :user_uid, primary_key: :uid
  enum status: %i(actived in_actived)
  enum role: %i(staff creator approval admin)

  scope :users_by_ids, ->(ids) { where("uid IN (?)", ids) }
end
