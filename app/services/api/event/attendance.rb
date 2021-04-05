# frozen_string_literal: true

class Api::Event::Attendance
  def initialize(args = {})
    @event = args[:event]
    @user = args[:user]
  end

  def execute
    result = TakePartInEvent.find_by!(
      event_uid: event,
      user_uid: user
    )

    raise Errors::ExceptionHandler::InvalidAction if result.presence?

    result.presence!
  end

  private
    attr_reader :event, :user
end
