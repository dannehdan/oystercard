require './lib/journey_log'

RSpec.describe JourneyLog do
  it 'stores to journeys as an array' do
    expect(JourneyLog.new).to be_instance_of JourneyLog
  end

  it 'has an array as a log' do
    expect(subject.trip_history).to eq []
  end
end