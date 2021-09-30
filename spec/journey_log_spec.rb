require './lib/journey_log'

describe JourneyLog do
  let(:journey_instance) { double :journey, :entry_station => "new station", :complete? => false }
  let(:journey_class) { double :journey, :new => :journey_instance }

  it 'has an array as a log' do
    expect(subject.journeys).to eq []
  end

  it 'returns an entry station at start' do
    new_log = JourneyLog.new(journey_class)
    expect(new_log.start("new station")).to eq(:journey_instance)
  end

  it 'logs a journey' do
    dbl_entry = double ( "entry station" )
    dbl_exit = double ( "exit station" )

    subject.start(dbl_entry)
    subject.finish(dbl_exit)

    expect(subject.journeys).to eq([{start: dbl_entry, finish: dbl_exit}])
  end
end