# frozen_string_literal: true

class TemplateFeedback < ApplicationRecord
  belongs_to :event,
             foreign_key: :event_uid,
             primary_key: :uid

  has_many :questions,
           foreign_key: :template_feedback_uid,
           primary_key: :uid

  validates :event_uid,
            presence: true,
            uniqueness: true
end
