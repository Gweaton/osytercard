require 'oystercard'

describe Oystercard do
  subject(:oyster) {described_class.new}

  context "new card" do
    it 'has an initial balance of 0' do
      expect(oyster.balance).to eq 0
    end
  end
end
