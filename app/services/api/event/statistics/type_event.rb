# frozen_string_literal: true

class Api::Event::Statistics::TypeEvent
  def execute
    type_events = Suggestion.group(:type_event_uid).count
    total = Suggestion.count
    type_event = []
    values = []
    type_events.each do |key, value|
      type_event << "#{TypeEvent.find(key).name}"
<<<<<<< HEAD
      values << (value/total.to_f * 100).round(2)
    end
    {
      type_event: type_event,
      value: values
=======
      value << (value/total.to_f * 100).round(2)
    end
    {
      type_event: type_event,
      value: value
>>>>>>> fix_type_event
    }
  end
end
