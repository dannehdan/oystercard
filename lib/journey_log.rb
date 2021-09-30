require './lib/journey'

class JourneyLog

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @trip_history = []
  end

  def journeys
    @trip_history.dup
  end
  
  def start(station)
    @current_journey = @journey_class.new(station)
  end

  def finish(station)
    current_journey.finish(station)
    @trip_history << @current_journey.completed_journey
    @current_journey = nil
  end

  private

  def current_journey
    @current_journey ||= @journey_class.new
  end
  # def get_trip_history
  #   @trip_history
  # end

  # def add_to_trip_history(journey)
  #   @trip_history << journey
  # end
end
