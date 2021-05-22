# frozen_string_literal: true

class GoogleCalendar::Create < GoogleCalendar::AuthClient
  def initialize(event, user)
    @client = authorize
    @event = event
    @user = user
  end

  def execute
    new_event_payload = Google::Apis::CalendarV3::Event.new(
      summary: event.event_name,
      description: "#{event.description[0..100]}...",
      start: { date_time: event.start_at.iso8601 },
      end: { date_time: event.end_at.iso8601 },
      # send_notifications: true,
      guests_can_invite_others: false,
      attendees: [
        Google::Apis::CalendarV3::EventAttendee.new(
          email: user.email
        )
      ]
    )
    new_event = client.insert_event("primary", new_event_payload)
    Calendar.create(event_uid: event.uid, id_calendar: new_event.id)
  end

  private
    attr_reader :client, :event, :user
end
