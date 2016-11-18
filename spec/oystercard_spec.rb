require 'oystercard'

describe Oystercard do
  subject(:oyster) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) {double :exit_station}
  let(:journey) { double :journey }

  before do
      allow(journey).to receive(:start).with(entry_station)
      allow(journey).to receive(:finish).with(exit_station)
      allow(journey).to receive(:save_trip).and_return({ entry_station: entry_station, exit_station: exit_station })
      allow(journey).to receive(:total_fare)
  end

    context "new card" do
    it 'should have a default balance' do
      expect(oyster.balance).to eq 0
    end
    it 'should have an empty journey history' do
      expect(oyster.journey_history).to be_empty
    end
  end

    context "topping up" do
      it 'should add money to the card' do
        oyster.top_up(10)
        expect(oyster.balance).to eq 10
      end
      it 'should have a maximum balance of £90' do
        oyster.top_up(90)
        expect{ oyster.top_up(1) }.to raise_error "Card cannot be loaded over £#{Oystercard::MAXIMUM_BALANCE}."
      end
      it 'should not be able to top up over £90' do
        expect{ oyster.top_up(100) }.to raise_error "Card cannot be loaded over £#{Oystercard::MAXIMUM_BALANCE}."
      end
    end

    context "Minimum balance" do
      it 'should not allow touching in when balance is less than minimum balance' do
        expect{oyster.touch_in(entry_station)}.to raise_error("Not enough funds to travel")
      end
    end

    context "touching out" do
        before do
          oyster.top_up(10)
          oyster.touch_in(entry_station)
          allow(journey).to receive(:total_fare) {1}
        end
      it 'should store the trip in journey_history' do
        oyster.touch_out(exit_station)
        expect(oyster.journey_history).to eq [{ entry_station: entry_station, exit_station: exit_station }]
      end
      it 'should deduct a fare from the card' do
        expect{ oyster.touch_out(exit_station) }.to change{ oyster.balance }.by(-1)
      end
    end



  end
