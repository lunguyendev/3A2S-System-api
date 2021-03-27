# frozen_string_literal: true

class Api::Event::FilterEvent
  def initialize(args = {})
    @type = args[:type]
  end

  def execute
    case type
    when "pending"
      Event.pending
    when "cancel"
      Event.cancel
    when "accept"
      Event.accept
    else
      Event.all
    end
  end

  private
    attr_reader :type
end
