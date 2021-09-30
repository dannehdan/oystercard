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

  def touch_in(station)
    deduct(@current_journey.fare) if @current_journey != nil
    raise "Insufficient funds for journey" if @balance < MIN_AMOUNT
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey = Journey.new if @current_journey == nil
    @current_journey.finish(station)
    deduct(@current_journey.fare)
    @trip_history << @current_journey.completed_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
