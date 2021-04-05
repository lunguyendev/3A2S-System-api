# frozen_string_literal: true

class Api::Event::JoinerEvent
  def initialize(args = {})
    @event = args[:event_uid]
    @user = args[:user_uid]
  end

  def execute
    raise Errors::ExceptionHandler::InvalidAction if check_join_event?

    target_event.take_part_in_events.create(user_uid: user)
  end

  private
    attr_reader :event, :user

    def target_event
      @target_event ||= Event.find(event)
    end

    def check_join_event?
      return true if target_event.take_part_in_events.find_by(user_uid: user)

      false
    end
end
