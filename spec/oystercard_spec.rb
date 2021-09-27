require './lib/oystercard'

describe Oystercard do
  let(:card_limit) { Oystercard::CARD_LIMIT }
  
  it 'gives a new oystercard with a balance of 0' do
    expect(subject.balance).to eq 0
  end
  
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    
    it 'tops up oystercard by £10' do
      subject.top_up(10)

      expect(subject.balance).to eq 10
    end

    it 'balance cannot exceed card limit' do
      subject.top_up(card_limit)

      expect { subject.top_up(1) }.to raise_error "Cannot exceed limit of £#{card_limit}"
    end
  
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts oystercard by £10' do
      subject.top_up(20)

      expect(subject.deduct(10)).to eq 10
    end
  end 

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?)}
  end

end