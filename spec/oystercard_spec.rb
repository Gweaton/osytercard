require 'oystercard'

describe Oystercard do
  subject(:oyster) {described_class.new}

  context "new card" do
    it 'has an initial balance of 0' do
      expect(oyster.balance).to eq 0
    end
  end

  describe "#top_up" do
    it 'should have a top_up method' do
      expect(oyster).to respond_to(:top_up).with(1).argument
    end
    it 'should add to the current balance' do
      expect(oyster.top_up(10)).to eq 10
    end
    it 'should show the topped up balance' do
      oyster.top_up(10)
      expect(oyster.balance).to eq 10
    end
  end
end
