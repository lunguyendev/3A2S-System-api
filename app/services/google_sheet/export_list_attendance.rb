# frozen_string_literal: true

class GoogleSheet::ExportListAttendance
  def initialize(args = {})
    @worksheet = GoogleSheet::FindWorksheetService.new(
      spreadsheet_key: args[:spreadsheet_key],
      name_sheet: args[:name_sheet]
    ).execute
    @event = args[:event]
  end

  def execute
    updated_at
    worksheet.update_cells(8, 1, handle_data)
    worksheet.save
  end

  private
    attr_reader :event, :list, :worksheet

    def updated_at
      info_event = statistics
      worksheet["A1"] = "Name"
      worksheet["B1"] = info_event[:event_name]
      worksheet["A2"] = "Joins"
      worksheet["B2"] = info_event[:count_join]
      worksheet["A3"] = "Attendance"
      worksheet["B3"] = info_event[:count_attendance]
      worksheet["A4"] = "Cancel"
      worksheet["B4"] = info_event[:count_cancel]
      worksheet["A5"] = "Create at"
      worksheet["B5"] = Time.now.strftime("%d/%m/%Y %k:%M %p")
      worksheet["A6"] = "Create by"
      worksheet["B6"] = "3A2S System"
      worksheet["A7"] = "ID"
      worksheet["B7"] = "Name"
      worksheet["C7"] = "Email"
      worksheet["D7"] = "Phone"
      worksheet["E7"] = "Gender"
      worksheet["F7"] = "Class"
      worksheet["G7"] = "Status"
    end

    def take_part_in_events
      @list ||= event.take_part_in_events
    end

    def handle_data
      data = []
      take_part_in_events.each do |item|
        user = item.user
        data << GoogleSheet::AttendanceData.new(
          id: user.id_student || user.id_lecturer,
          name: user.name,
          email: user.email,
          phone: user.phone,
          gender: user.gender,
          class_name: user.class_activity,
          attendance: item.status
        ).execute
      end
      data
    end

    def statistics
      {
        event_name: event.event_name,
        count_attendance: take_part_in_events.presence.count,
        count_join: take_part_in_events.count,
        count_cancel: take_part_in_events.cancel.count
      }
    end
end
