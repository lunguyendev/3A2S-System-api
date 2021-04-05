# frozen_string_literal: true

class Api::Event::CreatorQrEvent
  def initialize(args = {})
    @object = args[:object]
    @expired_time = args[:expired_time || 1]
  end

  def execute
    raise Errors::ExceptionHandler::InvalidAction if exist_object?

    Token.create!(qr_code: object, expired_at: Time.now + expired_time.to_i.hours)
  end

  private
    attr_reader :object, :expired_time

    def exist_object?
      return true if Token.find_by(qr_code_id: object.uid)

      false
    end
end
