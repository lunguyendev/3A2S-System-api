# frozen_string_literal: true

class GoogleSheet::ImportDataEvent
  include Util::Generation
  Faker::Config.locale = :vi
  def initialize(args = {})
    @worksheet = GoogleSheet::FindWorksheetService.new(
      spreadsheet_key: args[:spreadsheet_key],
      name_sheet: args[:name_sheet]
    ).execute
  end

  EVENT_ATTR = {
    user_uid: User.find_by(email: "admin@dtu.edu.com").uid,
    event_name: 1,
    size: 3,
    organization: 4,
    description: 5,
    start_at: 6,
    end_at: 7,
    location: 8,
    is_online: false,
    scope: 10,
    avatar: 11,
    handel_by: Faker::Name.name,
    status: "accept"
  }.freeze

  def execute
    data = worksheet.rows[1..-1]

    data.each do |item|
      Event.create!(
        user_uid: EVENT_ATTR[:user_uid],
        event_name: item[EVENT_ATTR[:event_name]],
        size: item[EVENT_ATTR[:size]].to_i,
        organization: item[EVENT_ATTR[:organization]],
        description: item[EVENT_ATTR[:description]],
        start_at: EVENT_ATTR[:start_at],
        end_at: item[EVENT_ATTR[:end_at]],
        location: item[EVENT_ATTR[:location]],
        is_online: EVENT_ATTR[:is_online],
        scope: item[EVENT_ATTR[:scope]].to_i || 0,
        avatar: item[EVENT_ATTR[:avatar]],
        handel_by: EVENT_ATTR[:handel_by],
        status: EVENT_ATTR[:status]
      )
    end
  end

  private
    attr_reader :worksheet, :spreadsheet_key, :name_sheet
end
