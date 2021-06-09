# frozen_string_literal: true

class Api::V1::SuggestionController < ApplicationController
  def index
    events = Api::Event::Suggestion.new(@current_user.uid).execute

    render json: events, each_serializer: Api::V1::EventSerializer
  end

  def type_event_statistics
    statistics = Api::Event::Statistics::TypeEvent.new.execute

    render json: statistics
  end
end
