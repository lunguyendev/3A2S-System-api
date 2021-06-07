# frozen_string_literal: true

class Api::Event::Management::FilterEventAdmin
  def initialize(args = {})
    @user = args[:user_management]
    @type = args[:type]
  end

  def execute
    case type
    when "organized"
      user.events.accept.organized.created_at_desc
    when "organizing"
      user.events.accept.organizing.created_at_desc
    else
      raise Errors::ExceptionHandler::InvalidAction
    end
  end

  private
    attr_reader :type, :user
end
