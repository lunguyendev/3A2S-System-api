# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :template_feedback, foreign_key: :template_feedback_uid, primary_key: :uid
  has_many :answers, foreign_key: :question_uid, primary_key: :uid
end
