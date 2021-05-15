# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question, foreign_key: :question_uid, primary_key: :uid
  has_many :user, foreign_key: :user_uid, primary_key: :uid
end
