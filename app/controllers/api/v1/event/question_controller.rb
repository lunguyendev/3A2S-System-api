# frozen_string_literal: true

class Api::V1::Event::QuestionController < ApplicationController
  def index
    render json: target_template.questions, each_serializer: Api::V1::QuestionSerializer
  end

  private
    def target_template
      @template ||= TemplateFeedback.find(params[:template_feedback_id])
    end
end
