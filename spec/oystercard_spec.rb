require './lib/oystercard'

describe Oystercard do
  it 'gives a new oystercard with a balance of 0' do
    expect(subject.balance).to eq 0
  end
end