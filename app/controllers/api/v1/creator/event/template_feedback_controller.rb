# frozen_string_literal: true

class Api::V1::Creator::Event::TemplateFeedbackController < CreatorController
  def create
    template_feedback = TemplateFeedback.create!(event_uid: target_event.uid)
    # template_feedback.update!(params_template_feedback)

    render json: { template_uid: template_feedback.uid }, status: :ok
  end

  def params_template_feedback
    params.require(:template_feedback)
          .permit(:is_online, :sheet_id, :name_sheet)
  end

  def target_event
    Event.find(params[:event_uid])
  end
end
