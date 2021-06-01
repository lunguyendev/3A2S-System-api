# frozen_string_literal: true

class Api::Event::Statistics::Admin
  def initialize(year)
    @year = year.to_i
  end

  def execute
    {
      statistical: handle_data
    }
  end

  private
    attr_reader :year

    def handle_data
      data = []
      (1..12).each do |month|
        data <<
        {
            event: Event.with_year_and_month(year, month),
            join: TakePartInEvent.with_year_and_month(year, month)
        }
      end
      data
    end
end
