class Journey
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :trip_history

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def completed_journey
    {start: @entry_station, finish: @exit_station}
  end

  def fare(penalty = false)
    @exit_station = "No tap out" if penalty
    penalty ? PENALTY_FARE : 1
  end

end
