class Journey
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :trip_history

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end
  
  def finish(exit_station = nil)
    @exit_station = exit_station
    @complete = true if @entry_station
  end

  def complete?
    @complete
  end

  def completed_journey
    {start: @entry_station, finish: @exit_station}
  end

  def fare
    @complete == false ? PENALTY_FARE : 1
  end

end
