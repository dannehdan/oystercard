class Oystercard

  attr_reader :balance, :in_use, :entry_station

  CARD_LIMIT = 90
  MIN_AMOUNT = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Cannot exceed limit of £#{CARD_LIMIT}" if (balance + amount) > CARD_LIMIT
    @balance += amount
  end
  
  def in_journey?
    @in_use
  end
  
  def touch_in(entry_station)
    fail "Insufficient funds for journey" if @balance < MIN_AMOUNT
    @entry_station = entry_station
    @in_use = true
  end
  
  def touch_out
    deduct(MIN_AMOUNT)
    @entry_station = nil
    @in_use = false
  end
  
  private
  
  def deduct(amount)
    @balance -= amount
  end

end