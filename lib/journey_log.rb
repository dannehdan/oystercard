require './lib/journey'

class JourneyLog

  attr_reader :trip_history

  def initialize(current_journey = Journey.new)
    @journey = current_journey
    @trip_history = []
  end

  def get_trip_history
    @trip_history
  end

  def add_to_trip_history(journey)
    @trip_history << journey
  end
end
