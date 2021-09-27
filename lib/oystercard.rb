class Oystercard

  attr_reader :balance

  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Cannot exceed limit of £90" if (balance + amount) > CARD_LIMIT
    @balance += amount
  end
  
end