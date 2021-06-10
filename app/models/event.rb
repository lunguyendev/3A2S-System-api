# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user, foreign_key: :user_uid, primary_key: :uid
  has_many :take_part_in_events, foreign_key: :event_uid, primary_key: :uid
  has_one :template_feedback, foreign_key: :event_uid, primary_key: :uid
  has_one :calendar, foreign_key: :event_uid, primary_key: :uid
  has_one :token, as: :qr_code
  enum status: %i(pending cancel accept)

  scope :created_at_desc, -> { order created_at: :desc }
  scope :organized, -> { where("end_at < ?", DateTime.now) }
  scope :organizing, -> { where("end_at >= ?", DateTime.now) }
  scope :joined_event, -> (events) { where("uid IN (?)", events) }
  scope :count_events_by_day, -> (start_at, end_at) { where("created_at BETWEEN ? AND ?", start_at, end_at).group(:created_at).order(:created_at).count }
  scope :events_by_day, -> (start_at, end_at) { where("created_at BETWEEN ? AND ?", start_at, end_at).order(:start_at) }
  scope :with_year_and_month, ->(year, month) {
    where(created_at: Date.new(year, month, 1)..Date.new(year, month, -1)).count
  }
  scope :cal_scope_by_uids, ->(uids) { where(uid: uids).sum(:scope) }
  scope :search_by_type_event, -> (type_event) { where("type_event_uids && ARRAY[?]::varchar[]", type_event) }
  scope :event_not_uid, -> (events) { where.not(uid: events) }
  after_create :create_template

  validate :valid_dates

  def valid_dates
    if start_at >= end_at - 1.hours
      self.errors.add :start_time, ' has to be after end time'
    end
  end

  def create_template
    create_template_feedback
  end
end
