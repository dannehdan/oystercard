require './lib/journey'

class Oystercard
  attr_reader :balance, :in_journey, :trip_history

  CARD_LIMIT = 90
  MIN_AMOUNT = 1

  def initialize
    @balance = 0
    @trip_history = []
    @in_journey = false
  end

  def top_up(amount)
    raise "Cannot exceed limit of £#{CARD_LIMIT}" if (@balance + amount) > CARD_LIMIT

    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(current_journey = Journey.new, entry_station)
    raise "Insufficient funds for journey" if @balance < MIN_AMOUNT
    @current_journey = current_journey
    @in_journey = true
    @current_journey.entry(entry_station)


  end

  def touch_out(exit_station)
    deduct(MIN_AMOUNT)
    @current_journey.exit(exit_station)
    @in_journey = false
    @trip_history << @current_journey.completed_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
