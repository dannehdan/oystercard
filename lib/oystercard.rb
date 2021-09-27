class Oystercard

  attr_reader :balance, :in_use

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
  
  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    fail "Not enough money for journey" if @balance < MIN_AMOUNT
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

end