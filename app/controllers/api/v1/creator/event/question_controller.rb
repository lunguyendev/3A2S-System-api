# frozen_string_literal: true

class Api::V1::Creator::Event::QuestionController < CreatorController
  def create
    target_template.questions.destroy_all
    params_question.each do |params|
      target_template.questions.create!(params)
    end
    render json: target_template.questions, each_serializer: Api::V1::QuestionSerializer
  end

  def index
    render json: target_template.questions, each_serializer: Api::V1::QuestionSerializer
  end

  private
    def params_question
      params.require(:question).map do |params_question|
        params_question.permit(:is_rating, :content)
      end
    end

    def target_template
      @template ||= TemplateFeedback.find(params[:template_feedback_id])
    end
end
