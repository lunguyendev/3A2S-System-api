# frozen_string_literal: true

class Api::V1::Event::AnswerController < ApplicationController
  def create
    check_attendance_event
    answers_param.each do |answer_param|
      answer = answer_param.merge({ user_uid: @current_user.uid })
      Answer.create!(answer)
    end

    target_take_part_in_events.update(evaluated: true)
    render json: { status: "Answer submit success" }, status: :created
  end

  private
    def check_attendance_event
      attendance_event = target_take_part_in_events

      unless attendance_event&.presence? &&
             Question.answer_by_template(target_event.template_feedback&.uid, @current_user.uid).empty?
        raise Errors::ExceptionHandler::InvalidAction
      end
    end

    def answers_param
      params.require(:answers).map do |params_answer|
        params_answer.permit(:question_uid, :scope, :comment)
      end
    end

    def target_event
      @event ||= Event.find(params[:event_uid])
    end

    def target_take_part_in_events
      @attandance ||= TakePartInEvent.find_by(
        event_uid: target_event.uid,
        user_uid: @current_user.uid
      )
    end
end
