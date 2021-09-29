require './lib/station'

describe Station do
  describe '#initialize' do
    it { is_expected.to respond_to(:name, :zone) }
  end
end
