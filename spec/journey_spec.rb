require './lib/journey'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'has an entry station' do
    new_journey = Journey.new(entry_station)
    expect(new_journey.entry_station).to eq(entry_station)
  end

  it 'has an exit station' do
    subject.finish(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end

  it 'returns a complete journey' do
    new_journey = Journey.new(entry_station)
    new_journey.finish(exit_station)

    expect(new_journey.completed_journey).to eq( {start: entry_station, finish: exit_station} )
  end

  it 'returns a fare' do
    new_journey = Journey.new(entry_station)
    new_journey.finish(exit_station)
    expect(new_journey.fare).to eq 1
  end

end
