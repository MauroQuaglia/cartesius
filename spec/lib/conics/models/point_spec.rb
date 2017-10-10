require_relative('../../../spec_helper')
require_relative('../../../../lib/conics/models/point')

describe Conics::Point do

  describe '.new' do

    describe 'empty set' do

      it 'should reject a simple equation' do
        # x^2 + y^2 = -1 --> x^2 + y^2 + 1 = 0
        expect {described_class.new(x: 0, y: 0, k: 1)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 = -1 --> x^2 + y^2 + 2x - 2y + 3 = 0
        expect {described_class.new(x: 2, y: -2, k: 3)}.to raise_error(ArgumentError)
      end

    end

    describe 'point' do

      it 'should accept a simple equation' do
        # x^2 + y^2 = 0
        expect {described_class.new(x: 0, y: 0, k: 0)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 0 --> x^2 + y^2 + 2x - 2y + 2 = 0
        expect {described_class.new(x: 2, y: -2, k: 2)}.not_to raise_error
      end

    end

    describe 'circumference' do

      it 'should reject a simple equation' do
        # x^2 + y^2 = 1 --> x^2 + y^2 - 1 = 0
        expect {described_class.new(x: 0, y: 0, k: -1)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 1 --> x^2 + y^2 + 2x - 2y + 1 = 0
        expect {described_class.new(x2: 1, y2: 1, x: 2, y: -2, k: 1)}.to raise_error(ArgumentError)
      end

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