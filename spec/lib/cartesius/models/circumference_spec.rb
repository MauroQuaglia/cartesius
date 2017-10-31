require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/circumference')
require_relative('../../../../lib/cartesius/models/point')

describe Cartesius::Circumference do

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

      it 'should reject a simple equation' do
        # x^2 + y^2 = 0
        expect {described_class.new(x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 0 --> x^2 + y^2 + 2x - 2y + 2 = 0
        expect {described_class.new(x: 2, y: -2, k: 2)}.to raise_error(ArgumentError)
      end

    end

    describe 'circumference' do

      it 'should accept a simple equation' do
        # x^2 + y^2 = 1 --> x^2 + y^2 - 1 = 0
        expect {described_class.new(x: 0, y: 0, k: -1)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 1 --> x^2 + y^2 + 2x - 2y + 1 = 0
        expect {described_class.new(x: 2, y: -2, k: 1)}.not_to raise_error
      end

    end

  end

  describe '.unitary'do

    it 'should be the unitary circumference' do
      circumference = described_class.unitary

      expect(circumference.center).to eq(Cartesius::Point.origin)
      expect(circumference.radius).to eq(1)
    end

  end

  describe '#==' do

    it 'should be false when not circumference' do
      expect(
          described_class.unitary == NilClass
      ).to be_falsey
    end

  end

  describe '.unitary?' do

    it 'should be false' do
      circumference = described_class.new(x: -2, y: 2, k: -2)

      expect(
          circumference.unitary?
      ).to be_falsey
    end

    it 'should be true' do
      circumference = described_class.unitary

      expect(
          circumference.unitary?
      ).to be_truthy
    end

  end

  describe '.by_definition' do

    it 'should be the simplest' do
      circumference = described_class.by_definition(focus: Cartesius::Point.origin, radius: 1)

      expect(circumference.center).to eq(Cartesius::Point.origin)
      expect(circumference.radius).to eq(1)
    end

    it 'should be the generic' do
      circumference = described_class.by_definition(focus: Cartesius::Point.new(x: -1, y: 1), radius: 2)

      expect(circumference.center).to eq(Cartesius::Point.new(x: -1, y: 1))
      expect(circumference.radius).to eq(2)
    end

  end

  describe '.by_canonical' do

    it 'should be the simplest' do
      circumference = described_class.by_canonical(focus: Cartesius::Point.origin, radius: 1)

      expect(circumference.center).to eq(Cartesius::Point.origin)
      expect(circumference.radius).to eq(1)
    end

    it 'should be the generic' do
      circumference = described_class.by_canonical(focus: Cartesius::Point.new(x: -1, y: 1), radius: 2)

      expect(circumference.center).to eq(Cartesius::Point.new(x: -1, y: 1))
      expect(circumference.radius).to eq(2)
    end

  end

  describe '.by_points' do

    context 'bad parameters' do

      it 'should fail when points are not distinct' do
        expect {
          described_class.by_points(point1: Cartesius::Point.origin, point2: Cartesius::Point.origin, point3: Cartesius::Point.new(x: 1, y: 1))
        }.to raise_error(ArgumentError, 'Points must be distinct!')

        expect {
          described_class.by_points(point1: Cartesius::Point.origin, point2: Cartesius::Point.new(x: 1, y: 1), point3: Cartesius::Point.origin)
        }.to raise_error(ArgumentError, 'Points must be distinct!')

        expect {
          described_class.by_points(point1: Cartesius::Point.new(x: 1, y: 1), point2: Cartesius::Point.origin, point3: Cartesius::Point.origin)
        }.to raise_error(ArgumentError, 'Points must be distinct!')
      end

      it 'should fail when points are aligned' do
        expect {
          described_class.by_points(point1: Cartesius::Point.new(x: -1, y: -1), point2: Cartesius::Point.origin, point3: Cartesius::Point.new(x: 1, y: 1))
        }.to raise_error(ArgumentError, 'Points must not be aligned!')
      end

    end

    it 'should be the simplest' do
      circumference = described_class.by_points(point1: Cartesius::Point.new(x: -1, y: 0), point2: Cartesius::Point.new(x: 0, y: 1), point3: Cartesius::Point.new(x: 1, y: 0))

      expect(circumference.center).to eq(Cartesius::Point.origin)
      expect(circumference.radius).to eq(1)
    end

    it 'should be the generic' do
      circumference = described_class.by_points(point1: Cartesius::Point.origin, point2: Cartesius::Point.new(x: 2, y: 2), point3: Cartesius::Point.new(x: 4, y: 0))

      expect(circumference.center).to eq(Cartesius::Point.new(x: 2, y: 0))
      expect(circumference.radius).to eq(2)
    end

  end

  describe '#congruent?' do

    it 'should not be congruent when not circumference' do
      circumference = described_class.by_definition(focus: Cartesius::Point.origin, radius: 1)

      expect(circumference.congruent?(Cartesius::Point.origin)).to be_falsey
    end

    it 'should not be congruent when different radius' do
      circumference1 = described_class.by_definition(focus: Cartesius::Point.origin, radius: 1)
      circumference2 = described_class.by_definition(focus: Cartesius::Point.origin, radius: 2)

      expect(
          circumference1.congruent?(circumference2)
      ).to be_falsey
    end

    it 'should be congruent' do
      circumference1 = described_class.by_definition(focus: Cartesius::Point.origin, radius: 1)
      circumference2 = described_class.by_definition(focus: Cartesius::Point.new(x: 1, y: 1), radius: 1)

      expect(
          circumference1.congruent?(circumference2)
      ).to be_truthy
    end

  end

  describe '#to_equation' do

    it 'should be the simplest' do
      circumference = described_class.by_definition(focus: Cartesius::Point.origin, radius: 1)

      expect(circumference.to_equation).to eq('+1x^2 +1y^2 -1 = 0')
    end

    it 'should be the generic' do
      circumference = described_class.by_definition(focus: Cartesius::Point.new(x: -1, y: 1), radius: 2)

      expect(circumference.to_equation).to eq('+1x^2 +1y^2 +2x -2y -2 = 0')
    end

  end

end