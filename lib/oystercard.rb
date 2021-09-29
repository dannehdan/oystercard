require './lib/journey'

class Oystercard
  attr_reader :balance, :in_use, :entry_station, :trip_history

  CARD_LIMIT = 90
  MIN_AMOUNT = 1

  def initialize
    @balance = 0
    @trip_history = []
    @entry_station = nil
  end

  def top_up(amount)
    raise "Cannot exceed limit of £#{CARD_LIMIT}" if (@balance + amount) > CARD_LIMIT

    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    raise "Insufficient funds for journey" if @balance < MIN_AMOUNT

    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_AMOUNT)
    add_trip_to_history(exit_station)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_trip_to_history(exit_station)
    @trip_history << {entry: @entry_station, exit: exit_station}
  end
end

oyster1 = Oystercard.new
# oyster1.top_up(50)
# oyster1.touch_in('kgx')
# oyster1.touch_out('ofx')
# oyster1.touch_in('waterloo')
# oyster1.touch_in('kengsington')
# oyster1.touch_out('bakerloo')

# p oyster1.trip_history