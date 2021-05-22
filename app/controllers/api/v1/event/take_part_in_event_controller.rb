# frozen_string_literal: true

class Api::V1::Event::TakePartInEventController < ApplicationController
  before_action :target_event
  def create
    Api::Event::JoinerEvent.new(
      event_uid: params[:event_uid],
      user_uid: @current_user.uid
    ).execute

    GoogleCalendar::AddEmail.new(@event.calendar.id_calendar, @current_user.email).execute if @event.is_online
    head :created
  end

  private
    def target_event
      @event = Event.find(params[:event_uid])
    end
end
