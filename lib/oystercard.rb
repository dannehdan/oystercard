require './lib/journey'

class Oystercard
  attr_reader :balance, :in_use, :entry_station, :trip_history

  CARD_LIMIT = 90
  MIN_AMOUNT = 1

  def initialize
    @balance = 0
    @trip_history = {}
  end

  def top_up(amount)
    raise "Cannot exceed limit of £#{CARD_LIMIT}" if (balance + amount) > CARD_LIMIT

    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    raise "Insufficient funds for journey" if @balance < MIN_AMOUNT

    @entry_station = entry_station
    add_trip_to_history("entry", entry_station)
  end

  def touch_out(exit_station)
    deduct(MIN_AMOUNT)
    @entry_station = nil
    add_trip_to_history("exit", exit_station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_trip_to_history(in_out, station)
    @trip_history[in_out.to_sym] = station
  end
end
