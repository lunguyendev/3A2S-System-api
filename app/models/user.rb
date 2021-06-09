# frozen_string_literal: true

class User < ApplicationRecord
  has_many :events, foreign_key: :user_uid, primary_key: :uid
  has_many :take_part_in_events, foreign_key: :user_uid, primary_key: :uid
  has_many :answers, foreign_key: :user_uid, primary_key: :uid
  has_many :suggestions, foreign_key: :user_uid, primary_key: :uid
  has_one :token, as: :qr_code, dependent: :destroy
  enum status: %i(actived inactived newer)
  enum role: %i(basic creator approval admin)
  enum gender: %i(male female)

  scope :users_by_ids, ->(ids) { where("uid IN (?)", ids) }
  validates :phone, uniqueness: true, allow_blank: true
  validates :email, uniqueness: true, allow_blank: false
  validates :id_student, uniqueness: true, allow_blank: true
  validates :id_lecturer, uniqueness: true, allow_blank: true
end
