# frozen_string_literal: true

class GoogleSheet::FindWorksheetService
  def initialize(args = {})
    @client_google_sheet = GoogleSheet::AuthService.new.execute
    @spreadsheet_key = args[:spreadsheet_key]
    @name_sheet = args[:name_sheet]
  end

  def execute
    worksheets = client_google_sheet.spreadsheet_by_key(spreadsheet_key)
                                    .worksheets.select { |ws| ws.title == name_sheet }
    return worksheets.first if worksheets.present?

    raise Errors::ExceptionHandler::InvalidAction.new I18n.t("message_response.export_excel_onl")
  end

  private
    attr_reader :client_google_sheet, :spreadsheet_key, :name_sheet
end
