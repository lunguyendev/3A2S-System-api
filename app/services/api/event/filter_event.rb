# frozen_string_literal: true

class Api::Event::FilterEvent
  def initialize(args = {})
    @type = args[:type]
    @user = args[:user]
  end

  def execute
    return raise Errors::ExceptionHandler::PermissionDenied if @user.basic?

    return creator if @user.creator?

    admin
  end

  private
    attr_reader :type, :user
    def creator
      case type
      when "pending"
        user.events.pending.created_at_desc
      when "cancel"
        user.events.cancel.created_at_desc
      when "accept"
        user.events.accept.created_at_desc
      else
        user.events.all.created_at_desc
      end
    end

    def admin
      case type
      when "pending"
        Event.pending.created_at_desc
      when "cancel"
        Event.cancel.created_at_desc
      when "accept"
        Event.accept.created_at_desc
      else
        Event.all.created_at_desc
      end
    end
end
