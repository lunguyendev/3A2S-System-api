# frozen_string_literal: true

class GoogleSheet::AttendanceData
  def initialize(args = {})
    @id = args[:id]
    @name = args[:name]
    @email = args[:email]
    @phone = args[:phone]
    @gender = args[:gender]
    @class_name = args[:class_name]
    @attendance = args[:attendance]
  end

  def execute
    [
      id,
      name,
      email,
      phone,
      gender,
      class_name,
      attendance,
    ]
  end

  private
    attr_reader :id, :name, :email, :phone, :class_name, :gender, :attendance
end
