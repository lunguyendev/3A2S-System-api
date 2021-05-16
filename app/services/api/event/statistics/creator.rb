# frozen_string_literal: true

class Api::Event::Statistics::Creator
  def initialize(template_uid)
    @template_uid = template_uid
  end

  def execute
    {
      total: total_score,
      question_rating: question_rating,
      question_comment: question_comment
    }
  end

  private
    attr_reader :template_uid

    def total_score
      Question.question_answers_is_rating(template_uid).average(:scope).to_f
    end

    def question_rating
      data_hash = Question.question_answers_is_rating(template_uid).group(:uid).average(:scope)
      question_rating = []
      data_hash.each do |key, value|
        param = {
          content: Question.find_by(uid: key)&.content,
          total_rating: value.to_f,
          detail: Answer.count_scope(key)
        }
        question_rating << param
      end
      question_rating
    end

    def question_comment
      data = Question.question_answers_is_comment(template_uid).group(:uid).pluck(:uid)
      question_comment = []
      data.each do |value|
        question = Question.find_by(uid: value)
        param = {
          content: question&.content,
          comment: question&.answers&.pluck(:comment)
        }
        question_comment << param
      end
      question_comment
    end
end
