# frozen_string_literal: true

class Api::V1::Event::TakePartInEventController < ApplicationController
  before_action :target_event
  def create
    Api::Event::JoinerEvent.new(
      event_uid: params[:event_uid],
      user_uid: @current_user.uid
    ).execute

    head :created
  end

  def cancel
    @attendance = target_event.take_part_in_events.find_by(user_uid: @current_user.uid)
    raise Errors::ExceptionHandler::InvalidAction unless @attendance.present?

    @attendance.cancel!
    head :accepted
  end

  private
    def target_event
      @event = Event.find(params[:event_uid])
    end
end
