# frozen_string_literal: true

class Api::Event::Statistics::TypeEvent
  def execute
    type_events = Suggestion.group(:type_event_uid).count
    total = Suggestion.count
    data = []
    type_events.each do |key, value|
      data << {
        "#{TypeEvent.find(key).name}": (value/total.to_f * 100).round(2)
      }
    end
    data
  end
end
