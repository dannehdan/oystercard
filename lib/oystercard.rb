class Oystercard

  attr_reader :balance, :in_use, :entry_station, :trip_history

  CARD_LIMIT = 90
  MIN_AMOUNT = 1

  def initialize
    @balance = 0
    @trip_history = {}
  end

  def top_up(amount)
    fail "Cannot exceed limit of £#{CARD_LIMIT}" if (balance + amount) > CARD_LIMIT
    @balance += amount
  end
  
  def in_journey?
    !@entry_station.nil?
  end
  
  def touch_in(entry_station)
    fail "Insufficient funds for journey" if @balance < MIN_AMOUNT
    @entry_station = entry_station
    @trip_history[:entry_station] = entry_station
  end
  
  def touch_out(exit_station)
    deduct(MIN_AMOUNT)
    @entry_station = nil
    @trip_history[:exit_station] = exit_station
  end
  
  private
  
  def deduct(amount)
    @balance -= amount
  end

end