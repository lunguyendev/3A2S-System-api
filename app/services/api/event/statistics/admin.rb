# frozen_string_literal: true

class Api::Event::Statistics::Admin
  def initialize(year)
    @year = year.to_i
  end

  def execute
    handle_data
  end

  private
    attr_reader :year

    def handle_data
      event_arr = []
      join_arr = []
      (1..12).each do |month|
        event_arr << Event.with_year_and_month(year, month)
        join_arr << TakePartInEvent.with_year_and_month(year, month)
      end

      {
        event: event_arr,
        join: join_arr
      }
    end
end
