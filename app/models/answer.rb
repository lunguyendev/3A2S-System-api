# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question, foreign_key: :question_uid, primary_key: :uid
  has_many :user, foreign_key: :user_uid, primary_key: :uid

  scope :count_scope, -> (question_uid) { where(question_uid: question_uid).group(:scope).count }
  scope :count_feedback, -> (questions) { where("question_uid IN (?)", questions).group(:user_uid).count.count }
end
