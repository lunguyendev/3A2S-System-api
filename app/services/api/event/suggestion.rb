# frozen_string_literal: true

class Api::Event::Suggestion
  def initialize(user_uid)
    @user_uid = user_uid
  end

  def execute
    suggestion
  end

  private
    attr_reader :user_uid

    def suggestion
      event_uid_suggestion = Suggestion.type_event_hot(user_uid)
      event_by_suggestion = Event.search_by_type_event(event_uid_suggestion).organizing
      event_join = Event.joined_event(TakePartInEvent.where(user_uid: user_uid).pluck(:uid)).organizing

      event_suggestions = (event_by_suggestion - event_join).sample(10)

      event_add = []
      if event_suggestions.count < 10
        event_add = Event.organizing.event_not_uid(event_suggestions.pluck(:uid)).sample(10 - event_suggestions.count)
      end

      event_suggestions + event_add
    end
end
