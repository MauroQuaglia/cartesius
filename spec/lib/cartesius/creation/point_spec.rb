require_relative('../../../spec_helper')
require('cartesius/point')

describe Cartesius::Point do

  describe '.new' do

    it 'should be the origin' do
      point = described_class.new(x: 0, y: 0)

      expect(point.x).to eq(0)
      expect(point.y).to eq(0)
    end

    it 'should be a generic point' do
      point = described_class.new(x: 1, y: -1)

      expect(point.x).to eq(1)
      expect(point.y).to eq(-1)
    end

    it 'should be a generic point with string parameters' do
      point = described_class.new(x: '1', y: '-1')

      expect(point.x).to eq(1)
      expect(point.y).to eq(-1)
    end
  end

  describe '.origin' do

    it 'should be the origin' do
      point = described_class.origin

      expect(point.x).to eq(0)
      expect(point.y).to eq(0)
    end

  end

end