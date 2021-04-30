# frozen_string_literal: true

class Api::V1::Event::TakePartInEventController < ApplicationController
  def create
    Api::Event::JoinerEvent.new(
      event_uid: params[:event_uid],
      user_uid: @current_user.uid
    ).execute

    head :created
  end

  private
    def target_event
      Event.find(params[:event_uid])
    end
end
