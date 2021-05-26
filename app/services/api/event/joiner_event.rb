# frozen_string_literal: true

class Api::Event::JoinerEvent
  def initialize(args = {})
    @event = args[:event_uid]
    @user = args[:user_uid]
  end

  def execute
    return target_event.take_part_in_events.find_by(user_uid: user).absent! if check_cancel?

    raise Errors::ExceptionHandler::InvalidAction if check_join_event? && check_creator_event?

    attendance = target_event.take_part_in_events.create(user_uid: user)
    GoogleCalendar::AddEmail.new(target_event.calendar.id_calendar, target_user.email).execute if target_event.is_online
    attendance
  end

  private
    attr_reader :event, :user

    def target_event
      @target_event ||= Event.accept.find_by!(uid: event)
    end

    def target_user
      @user ||= User.find(user)
    end

    def check_join_event?
      return true if target_event.take_part_in_events.find_by(user_uid: user)

      false
    end

    def check_creator_event?
      return true if target_event.user_uid === user

      false
    end

    def check_cancel?
      return true if target_event.take_part_in_events.find_by(user_uid: user)&.cancel?

      false
    end
end
