require_relative('../../spec/spec_helper')
require_relative('../../models/point')

describe Point do

  describe '.new' do

    context 'invalid parameters' do

      it 'should fail when empty set' do
        expect {
          described_class.new(x: 2, y: -2, k: 3)
        }.to raise_error(ArgumentError, 'Empty set!')
      end

      it 'should fail when circumference' do
        expect {
          described_class.new(x: 2, y: -2, k: 0)
        }.to raise_error(ArgumentError, 'Circumference!')
      end

    end

    it 'should be the origin' do
      point = described_class.new(x: 0, y: 0, k: 0)

      expect(point.x).to eq(0)
      expect(point.y).to eq(0)
    end

    it 'should be the generic point' do
      point = described_class.new(x: -2, y: 2, k: 2)

      expect(point.x).to eq(1)
      expect(point.y).to eq(-1)
    end

  end

end