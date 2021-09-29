class Journey
  def exists
    true
  end

  attr_reader :entry_station, :exit_station, :trip_history

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def entry(station)
    @entry_station = station
  end

  def exit(station)
    @exit_station = station
  end

  def completed_journey
    {entry: @entry_station, exit: @exit_station}
  end

end
