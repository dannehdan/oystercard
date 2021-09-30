require './lib/oystercard'
require './lib/journey'

describe Oystercard do
  let(:card_limit) { Oystercard::CARD_LIMIT }
  let(:min_amount) { Oystercard::MIN_AMOUNT }
  let(:penalty_fare) { Journey::PENALTY_FARE }

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  describe '#initialize' do
    it 'new oystercard starts with £0 balance and has no trip history' do
      expect(subject.balance).to eq 0
      expect(subject.trip_history).to be_empty
    end
  end

  describe '#top_up' do
    it 'tops up oystercard by £10' do
      subject.top_up(10)

      expect(subject.balance).to eq 10
    end

    it 'balance cannot exceed card limit' do
      expect { subject.top_up(card_limit + 1) }.to raise_error "Cannot exceed limit of £#{card_limit}"
    end
  end

  describe 'finance tracking' do
    it 'errors if balance is below minimum amount' do
      expect { subject.touch_in(entry_station) }.to raise_error "Insufficient funds for journey"
    end
  end

  describe 'touching in and out' do
    before(:each) do
      subject.top_up(card_limit)
    end

    describe '#touch_in' do
      it 'fines card if they touch in twice in a row' do
        subject.touch_in(entry_station)
        expect{ subject.touch_in(entry_station) }.to change { subject.balance }.by (-penalty_fare) 
      end
    end

    describe '#touch_out' do
      it 'deducts money from card on touch out' do
        subject.touch_in(entry_station)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-min_amount)
      end

      it 'fines the card if it no touch in' do
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-penalty_fare)
      end
    end

    describe 'journey' do
      it 'stores a single journey' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.trip_history).to eq([{ start: entry_station, finish: exit_station }])
      end
    end
  end
end
