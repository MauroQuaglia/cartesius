require_relative('../../spec_helper')
require('cartesius/point')

describe Cartesius::Point do

  describe '.distance' do

    it 'should be 0 for same points' do
      point1 = described_class.origin
      point2 = described_class.origin

      expect(described_class.distance(point1, point2)).to eq(0)
    end

    it 'should be the same from the points' do
      point1 = described_class.origin
      point2 = described_class.new(x: 3, y: 4)

      expect(described_class.distance(point1, point2)).to eq(5)
      expect(described_class.distance(point2, point1)).to eq(5)
    end

  end

  describe '#origin?' do

    it 'should be false' do
      point = described_class.new(x: 0, y: 1)

      expect(point.origin?).to be_falsey
    end

    it 'should be true' do
      point = described_class.origin

      expect(point.origin?).to be_truthy
    end

  end

  describe '#distance_from' do

    it 'should be 0 for same points' do
      point1 = described_class.origin
      point2 = described_class.origin

      expect(point1.distance_from(point2)).to eq(0)
    end

    it 'should be the same from the points' do
      point1 = described_class.origin
      point2 = described_class.new(x: 3, y: 4)

      expect(point1.distance_from(point2)).to eq(5)
      expect(point2.distance_from(point1)).to eq(5)
    end

  end

  describe '#to_coordinates' do

    it 'should be the origin' do
      expect(
          described_class.origin.to_coordinates
      ).to eq('(0; 0)')
    end

    it 'should be general' do
      expect(
          described_class.new(x: -1, y: +1).to_coordinates
      ).to eq('(-1; 1)')
    end

    it 'should be rational' do
      expect(
          described_class.new(x: '1/2', y: '-4/5').to_coordinates
      ).to eq('(1/2; -4/5)')
    end

  end

  describe '#congruent?' do

    it 'should be false when not point' do
      expect(described_class.origin == NilClass).to be_falsey
    end

    it 'should be true when same point' do
      point1 = described_class.origin
      point2 = described_class.origin

      expect(point1.congruent?(point2)).to be_truthy
    end

    it 'should be true when generic points' do
      point1 = described_class.origin
      point2 = described_class.new(x: 1, y: 1)

      expect(point1.congruent?(point2)).to be_truthy
    end

  end

  describe '#==' do

    it 'should be false when not point' do
      expect(described_class.origin == NilClass).to be_falsey
    end

    it 'should be false when different x' do
      point1 = described_class.new(x: 1, y: 0)
      point2 = described_class.new(x: -1, y: 0)

      expect(point1 == point2).to be_falsey
    end

    it 'should be false when different y' do
      point1 = described_class.new(x: 0, y: 1)
      point2 = described_class.new(x: 0, y: -1)

      expect(point1 == point2).to be_falsey
    end

    it 'should be true' do
      point1 = described_class.new(x: 1, y: -1)
      point2 = described_class.new(x: 1, y: -1)

      expect(point1 == point2).to be_truthy
    end

  end

  describe '.to_equation' do

    it 'should be the origin equation' do
      expect(described_class.origin.to_equation).to eq('+1x^2 +1y^2 = 0')
    end

    it 'should be the general equation' do
      point = described_class.new(x: 1, y: 1)
      expect(point.to_equation).to eq('+1x^2 +1y^2 -2x -2y +2 = 0')
    end

  end

end