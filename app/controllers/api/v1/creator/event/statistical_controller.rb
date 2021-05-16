# frozen_string_literal: true

class Api::V1::Creator::Event::StatisticalController < CreatorController
  def index
    return head :unauthorized unless check_creator_event?

    statistics = Api::Event::Statistics::Creator.new(target_event.template_feedback&.uid).execute
    render json: { statistics: statistics }, status: :ok
  end

  private
    def check_creator_event?
      return true if target_event.user_uid === @current_user.uid

      false
    end

    def target_event
      @event ||= Event.accept.find_by!(uid: params[:event_uid])
    end
end
