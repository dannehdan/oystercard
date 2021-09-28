require './lib/oystercard'

describe Oystercard do
  let(:card_limit) { Oystercard::CARD_LIMIT }
  let(:min_amount) { Oystercard::MIN_AMOUNT }
  
  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:touch_in)}
  it { is_expected.to respond_to(:touch_out)}
  it { is_expected.to respond_to(:in_journey?)}
  
    describe '#initialize' do
    it 'new oystercard starts with £0 balance and is not in use' do
      expect(subject.balance).to eq 0
      expect(subject.in_use).to be_nil
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

  describe 'touching in and out' do
    before(:each) do
      subject.top_up(card_limit)
    end

    let(:station) { double :station }

    describe '#touch_in' do

      it 'causes card to be in use' do
        subject.touch_in(station)

        expect(subject).to be_in_journey
      end

      it 'errors if balance is below minimum amount' do
        card_limit.times { subject.touch_out }
        expect { subject.touch_in(station) }.to raise_error "Insufficient funds for journey"
      end

      it 'remembers entry station after touch in' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end
    end

    describe '#touch_out' do
      it 'causes card to be not in use' do
        subject.touch_in(station)
        subject.touch_out

        expect(subject).not_to be_in_journey
      end

      it 'deducts money from card on touch out' do
        subject.touch_in(station)
        
        expect { subject.touch_out }.to change{ subject.balance }.by(-min_amount)
      end
    end
  end

end