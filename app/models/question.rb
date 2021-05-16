# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :template_feedback, foreign_key: :template_feedback_uid, primary_key: :uid
  has_many :answers, foreign_key: :question_uid, primary_key: :uid

  scope :answer_by_template, -> (template_uid, user_uid) { joins(:answers).where(template_feedback_uid: template_uid).merge(Answer.where(user_uid: user_uid)) }
  scope :question_answers_is_rating, -> (template_uid) { joins(:template_feedback, :answers).where(template_feedback_uid: template_uid, is_rating: true) }
  scope :question_answers_is_comment, -> (template_uid) { joins(:template_feedback, :answers).where(template_feedback_uid: template_uid, is_rating: false) }
end
