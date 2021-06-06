# frozen_string_literal: true

class GoogleSheet::ImportDataUser
  include Util::Generation
  def initialize(args = {})
    @worksheet = GoogleSheet::FindWorksheetService.new(
      spreadsheet_key: args[:spreadsheet_key],
      name_sheet: args[:name_sheet]
    ).execute
  end
 
  USER_ATTR = {
    name: 1,
    email: 2,
    phone: 3,
    gender: 4,
    class_activity: 5,
    id_student: 6,
    id_lecturer: 7,
    role: 8,
    type:9,
    birthday: "01-01-1999",
    status: "actived",
    password_user: generate_hash_password("password123")
  }.freeze

  def executeinclude Util::Generation
    data = worksheet.rows[2..-1]

    data.each do |item|
      User.create(
      name: item[USER_ATTR[:name]],
      email: item[USER_ATTR[:email]],
      phone: item[USER_ATTR[:phone]],
      gender: item[USER_ATTR[:gender]],
      birthday: USER_ATTR[:birthday],
      class_activity: item[USER_ATTR[:class_activity]],
      id_student: item[USER_ATTR[:id_student]],
      id_lecturer: item[USER_ATTR[:id_lecturer]],
      role: item[USER_ATTR[:role]],
      type: item[USER_ATTR[:type]],
      status: USER_ATTR[:status],
      hashed_password: USER_ATTR[:password_user]
      )
    end
  end

  private
    attr_reader :worksheet, :spreadsheet_key, :name_sheet
end
