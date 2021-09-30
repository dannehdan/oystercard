require './lib/journey'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'has an entry station' do
    subject.start(entry_station)
    expect(subject.entry_station).to eq(entry_station)
  end

  it 'has an exit station' do
    subject.finish(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end

  it 'returns a complete journey' do
    subject.start(entry_station)
    subject.finish(exit_station)

    expect(subject.completed_journey).to eq( {start: entry_station, finish: exit_station} )
  end

  # it 'returns a no tap out journey' do
  #   subject.entry(entry_station)
  #   subject.exit("No tap out")

  #   expect(subject.completed_journey).to eq( {})

  it 'returns a fare' do
    expect(subject.fare).to eq 1
  end

end
