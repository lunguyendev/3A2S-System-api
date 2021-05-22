# frozen_string_literal: true

class GoogleCalendar::CreateMeet < GoogleCalendar::AuthClient
  def initialize(id_calendar)
    @client = authorize
    @id_calendar = id_calendar
  end

  def execute
    event = client.get_event("primary", id_calendar)
    event.conference_data = {
      create_request: {
        request_id: "#{('a'..'z').to_a.shuffle[0, 10].join}",
        conference_solution_key: {
          type: "hangoutsMeet"
        },
        status: {
          status_code: "success"
        }
      }
    }
    event_update = client.update_event("primary", id_calendar, event, { conference_data_version: 1 })
    Calendar.update_meet_url(id_calendar, event_update.hangout_link)
  end

  private
    attr_reader :client, :id_calendar
end
