require_relative "journey"

class Oystercard

attr_reader :balance, :entry_station, :journey_history

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "Card cannot be loaded over £#{MAXIMUM_BALANCE}." if self.balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end


  def touch_in(entry_station, journey = Journey.new)
    fail "Not enough funds to travel" if self.balance < MINIMUM_BALANCE
    journey.start(entry_station)
    self.entry_station = entry_station
  end

  def in_journey?
    !self.entry_station.nil?
  end

  def touch_out(exit_station, journey)
    deduct(MINIMUM_BALANCE)
    journey.finish(exit_station)
    self.journey_history << journey.save_trip
    self.entry_station = nil
  end

  private
  attr_writer :balance, :entry_station

  def deduct(amount)
    self.balance -= amount
  end

end
