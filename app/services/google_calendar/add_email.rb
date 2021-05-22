# frozen_string_literal: true

class GoogleCalendar::AddEmail < GoogleCalendar::AuthClient
  def initialize(id_calendar, email)
    @client = authorize
    @id_calendar = id_calendar
    @email = email
  end

  def execute
    event = client.get_event("primary", id_calendar)
    event.attendees << Google::Apis::CalendarV3::EventAttendee.new(
      email: email
    )

    client.update_event("primary", id_calendar, event, { conference_data_version: 1 })
  end

  private
    attr_reader :client, :id_calendar, :email
end
