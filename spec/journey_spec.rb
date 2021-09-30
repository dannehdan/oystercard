require './lib/journey'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { Journey.new(entry_station) }

  it 'has an entry station' do
    expect(journey.entry_station).to eq(entry_station)
  end

  it 'has an exit station' do
    subject.finish(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end

  it 'returns a complete journey' do
    journey.finish(exit_station)

    expect(journey.completed_journey).to eq( {start: entry_station, finish: exit_station} )
  end

  it 'returns a fare' do
    journey.finish(exit_station)
    expect(journey.fare).to eq 1
  end

end
