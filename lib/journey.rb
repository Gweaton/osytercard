class Journey
  attr_reader :entry_station, :exit_station, :trip, :total_fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @total_fare = 0
    @entry_station = nil
    @exit_station = nil
    @trip = { entry_station: nil, exit_station: nil }
  end

  def start(station)
    fare if trip[:entry_station] != nil
    self.entry_station = station
    save_entry
  end

  def finish(station)
    self.exit_station = station
    save_exit
    fare
  end

  def incomplete?
    self.trip[:entry_station].nil? || self.trip[:exit_station].nil?
  end

  def complete?
    !incomplete?
  end

  def save_entry
    self.trip[:entry_station] = self.entry_station
  end

  def save_exit
    self.trip[:exit_station] = self.exit_station
  end

  private
  attr_writer :entry_station, :exit_station, :trip, :total_fare

  def fare
    return self.total_fare = MINIMUM_FARE if complete?
    self.total_fare = PENALTY_FARE
    self.trip[:entry_station] = nil
  end
end
