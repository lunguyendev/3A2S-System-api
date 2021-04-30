# frozen_string_literal: true

class Api::V1::Creator::EventController < CreatorController
  def create
    @current_user.events.create(params_event_create)

    head :created
  end

  private
    def params_event_create
      params.require(:event).permit(
        :type_event,
        :size,
        :organization,
        :description,
        :status,
        :start_at,
        :end_at
      )
    end
end
