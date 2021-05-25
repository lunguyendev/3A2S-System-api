# frozen_string_literal: true

class Api::Event::Management::FilterEvent
  def initialize(args = {})
    @user = args[:user_management]
    @type = args[:type]
  end

  def execute
    if user.admin? || user.approval?
      case type
      when "organized"
        Event.accept.organized.created_at_desc
      when "organizing"
        Event.accept.organizing.created_at_desc
      else
        raise Errors::ExceptionHandler::InvalidAction
      end
    else
      case type
      when "organized"
        user.events.accept.organized.created_at_desc
      when "organizing"
        user.events.accept.organizing.created_at_desc
      else
        raise Errors::ExceptionHandler::InvalidAction
      end
    end
  end

  private
    attr_reader :type, :user
end
