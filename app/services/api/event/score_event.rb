# frozen_string_literal: true

class Api::Event::ScoreEvent
  def initialize(user_uid)
    @user_uid = user_uid
  end

  def execute
    event_uid = TakePartInEvent.attendance(user_uid).pluck(:event_uid)

    Event.cal_scope_by_uids(event_uid)
  end

  private
    attr_reader :user_uid
end
