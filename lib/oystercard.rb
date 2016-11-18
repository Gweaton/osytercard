require_relative "journey"

class Oystercard

attr_reader :balance, :in_journey, :journey_history, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "Card cannot be loaded over £#{MAXIMUM_BALANCE}." if self.balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def touch_in(entry_station)
    fail "Not enough funds to travel" if self.balance < MINIMUM_BALANCE
    create_journey?
    journey.start(entry_station)
    deduct(self.journey.total_fare)
    start_journey
  end

  def touch_out(exit_station)
    create_journey?
    self.journey.finish(exit_station)
    deduct(self.journey.total_fare)
    save_journey
    end_journey
  end

  private
  attr_writer :balance, :in_journey

  def deduct(amount)
    self.balance -= amount
  end

  def create_journey?
    @journey = Journey.new if !in_journey?
  end

  def start_journey
    @in_journey = true
  end

  def in_journey?
    self.in_journey
  end

  def end_journey
    @in_journey = false
  end

  def save_journey
    self.journey_history << journey.trip
  end

end
