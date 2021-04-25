# frozen_string_literal: true

class Api::Event::FilterEvent
  def initialize(args = {})
    @type = args[:type]
  end

  def execute
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

  private
    attr_reader :type
end
