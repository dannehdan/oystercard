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

  # def in_journey?
  #   @in_journey
  # end

  def touch_in(station)
    deduct(@current_journey.fare) if @current_journey != nil
    #   @balance -= @current_journey.fare(true)
    #   @trip_history << @current_journey.completed_journey
    # end
    raise "Insufficient funds for journey" if @balance < MIN_AMOUNT
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey = Journey.new if @current_journey == nil
    @current_journey.finish(station)
    deduct(@current_journey.fare)
    # if in_journey?
    #   deduct(@current_journey.fare)
    #   @current_journey.finish(exit_station)
    # else
    #   @current_journey = Journey.new
    #   @current_journey.start("No touch in")
    #   @current_journey.finish(exit_station)
    #   deduct(@current_journey.fare(true))
    # end
    # @in_journey = false
    @trip_history << @current_journey.completed_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
