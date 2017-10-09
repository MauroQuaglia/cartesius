require_relative('../../../spec_helper')
require_relative('../../../../lib/conics/models/point')

describe Conics::Point do

  describe '.new' do

    context 'invalid parameters' do

      it 'should fail when empty set' do
        expect {
          described_class.new(x: 2, y: -2, k: 3)
        }.to raise_error(ArgumentError, 'Invalid coefficients!')
      end

      it 'should fail when circumference' do
        expect {
          described_class.new(x: 2, y: -2, k: 0)
        }.to raise_error(ArgumentError, 'Invalid coefficients!')
      end

    end

    it 'should be the origin' do
      point = described_class.new(x: 0, y: 0, k: 0)

      expect(point.x).to eq(0)
      expect(point.y).to eq(0)
    end

    it 'should be a generic point' do
      point = described_class.new(x: -2, y: 2, k: 2)

      expect(point.x).to eq(1)
      expect(point.y).to eq(-1)
    end

  end

  describe '.create' do

    it 'should be the origin' do
      point = described_class.create(x: 0, y: 0)

      expect(point.x).to eq(0)
      expect(point.y).to eq(0)
    end

    it 'should be a generic point' do
      point = described_class.create(x: 1, y: -1)

      expect(point.x).to eq(1)
      expect(point.y).to eq(-1)
    end

    it 'should be a generic point with string parameters' do
      point = described_class.create(x: '1', y: '-1')

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

  describe '.mid' do

    it 'should be the same when points are the same' do
      expect(
          described_class.mid(point1: described_class.origin, point2: described_class.origin)
      ).to eq(described_class.origin)
    end

    it 'should be the mid point' do
      expect(
          described_class.mid(point1: described_class.origin, point2: described_class.create(x: 2, y: 2))
      ).to eq(described_class.create(x: 1, y: 1))
    end

  end

  describe '.origin?' do

    it 'should be false' do
      point = described_class.create(x: 0, y: 1)

      expect(
          point.origin?
      ).to be_falsey
    end

    it 'should be true' do
      point = described_class.origin

      expect(
          point.origin?
      ).to be_truthy
    end

  end

  describe '.to_coordinates' do

    it 'should be the origin' do
      expect(
          described_class.origin.to_coordinates
      ).to eq('(0; 0)')
    end

    it 'should be general' do
      expect(
          described_class.create(x: -1, y: +1).to_coordinates
      ).to eq('(-1; 1)')
    end

    it 'should be rational' do
      expect(
          described_class.create(x: '1/2', y: '-4/5').to_coordinates
      ).to eq('(1/2; -4/5)')
    end

  end

  describe '#==' do

    it 'should be false when not point' do
      expect(
          described_class.origin == NilClass
      ).to be_falsey
    end

    it 'should be false when different x' do
      point1 = described_class.create(x: 1, y: 0)
      point2 = described_class.create(x: -1, y: 0)

      expect(
          point1 == point2
      ).to be_falsey
    end

    it 'should be false when different y' do
      point1 = described_class.create(x: 0, y: 1)
      point2 = described_class.create(x: 0, y: -1)

      expect(
          point1 == point2
      ).to be_falsey
    end

    it 'should be true' do
      point1 = described_class.create(x: 1, y: -1)
      point2 = described_class.create(x: 1, y: -1)

      expect(
          point1 == point2
      ).to be_truthy
    end

  end

end