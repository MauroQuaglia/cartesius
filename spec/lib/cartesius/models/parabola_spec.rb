require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/parabola')

describe Cartesius::Parabola do

  describe '.new' do

    describe 'line' do

      it 'should reject a simple equation' do
        # y = 0
        expect {described_class.new(x2: 0, x: 0, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # y = x + 1 --> x - y + 1 = 0
        expect {described_class.new(x2: 0, x: 1, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'parabola' do

      it 'should accept a simple equation' do
        # y = x^2 --> x^2 - y = 0
        expect {described_class.new(x2: 1, x: 0, k: 0)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # y = x^2 + x + 1 --> x^2 + x - y + 1 = 0
        expect {described_class.new(x2: 1, x: 1, k: 1)}.not_to raise_error
      end

    end

  end

  describe '.by_definition' do

    context 'directrix and focus' do

      it 'should fail when focus belongs to directrix' do
        expect {
          described_class.by_definition(directrix: Cartesius::Line.x_axis, focus: Cartesius::Point.origin)
        }.to raise_error(ArgumentError, 'Focus belongs to directrix!')
      end

      it 'should fail when directrix is not parallel to x-axis' do
        expect {
          described_class.by_definition(directrix: Cartesius::Line.ascending_bisector, focus: Cartesius::Point.new(x: -1, y: 1))
        }.to raise_error(ArgumentError, 'Directrix is not parallel to x-axis!')
      end

      it 'should be the simplest convex parabola' do
        expect(
            described_class.by_definition(
                directrix: Cartesius::Line.new(x: 0, y: 1, k: '1/4'), focus: Cartesius::Point.new(x: 0, y: '1/4'))
        ).to eq(described_class.new(x2: -1, x: 0, k: 0))
      end

      it 'should be the simplest concave parabola' do
        expect(
            described_class.by_definition(
                directrix: Cartesius::Line.new(x: 0, y: 1, k: '-1/4'), focus: Cartesius::Point.new(x: 0, y: '-1/4'))
        ).to eq(described_class.new(x2: 1, x: 0, k: 0))
      end

      it 'should be a generic convex parabola' do
        expect(
            described_class.by_definition(directrix: Cartesius::Line.new(x: 0, y: 1, k: '-11/4'), focus: Cartesius::Point.new(x: '3/4', y: 3))
        ).to eq(described_class.new(x2: -2, x: 3, k: -4))
      end

      it 'should be a generic concave parabola' do
        expect(
            described_class.by_definition(directrix: Cartesius::Line.new(x: 0, y: 1, k: '11/4'), focus: Cartesius::Point.new(x: '3/4', y: -3))
        ).to eq(described_class.new(x2: 2, x: -3, k: 4))
      end

    end

  end

  describe '.by points' do

    context 'bad parameters' do

      it 'should fail when same points' do
        expect {
          described_class.by_points(point1: Cartesius::Point.origin, point2: Cartesius::Point.origin, point3: Cartesius::Point.new(x: 1, y: 1))
        }.to raise_error(ArgumentError, 'Points must be distinct!')
      end
    end

    it 'should be the simplest convex parabola' do
      expect(
          described_class.by_points(point1: Cartesius::Point.new(x: -1, y: 1), point2: Cartesius::Point.origin, point3: Cartesius::Point.new(x: 1, y: 1))
      ).to eq(described_class.new(x2: -1, x: 0, k: 0))
    end

    it 'should be the simplest concave parabola' do
      expect(
          described_class.by_points(point1: Cartesius::Point.new(x: -1, y: -1), point2: Cartesius::Point.origin, point3: Cartesius::Point.new(x: 1, y: -1))
      ).to eq(described_class.new(x2: 1, x: 0, k: 0))
    end
  end

  describe '.unitary_convex' do

    it 'should be the unitary convex parabola' do
      parabola = described_class.unitary_convex

      expect(parabola.focus).to eq(Cartesius::Point.new(x: 0, y: '1/4'))
      expect(parabola.vertex).to eq(Cartesius::Point.origin)
      expect(parabola.directrix).to eq(Cartesius::Line.horizontal(known_term: '-1/4'))
      expect(parabola.symmetry_axis).to eq(Cartesius::Line.y_axis)
    end

  end

  describe '.unitary_concave' do

    it 'should be the unitary concave parabola' do
      parabola = described_class.unitary_concave

      expect(parabola.focus).to eq(Cartesius::Point.new(x: 0, y: '-1/4'))
      expect(parabola.vertex).to eq(Cartesius::Point.origin)
      expect(parabola.directrix).to eq(Cartesius::Line.horizontal(known_term: '1/4'))
      expect(parabola.symmetry_axis).to eq(Cartesius::Line.y_axis)
    end

  end

  describe '#unitary_convex?' do

    it 'should be false' do
      parabola = described_class.unitary_concave

      expect(
          parabola.unitary_convex?
      ).to be_falsey
    end

    it 'should be true' do
      parabola = described_class.unitary_convex

      expect(
          parabola.unitary_convex?
      ).to be_truthy
    end

  end

  describe '#unitary_concave?' do

    it 'should be false' do
      parabola = described_class.unitary_convex

      expect(
          parabola.unitary_concave?
      ).to be_falsey
    end

    it 'should be true' do
      parabola = described_class.unitary_concave

      expect(
          parabola.unitary_concave?
      ).to be_truthy
    end

  end

  describe '#==' do

    it 'should be false when not parabola' do
      expect(
          described_class.unitary_convex == NilClass
      ).to be_falsey
    end

    it 'should be false when different focus' do
    end

    it 'should be false when different directrix' do
    end

    it 'should be true' do
      parabola1 = described_class.unitary_convex
      parabola2 = described_class.unitary_convex

      expect(
          parabola1 == parabola2
      ).to be_truthy
    end

  end

  describe '#to_equation' do

    it 'should be the simplest' do
      parabola = described_class.unitary_convex

      expect(parabola.to_equation).to eq('+1x^2 -1y = 0')
    end

    it 'should be the generic' do
      parabola = described_class.by_definition(directrix: Cartesius::Line.new(x: 0, y: 1, k: '11/4'), focus: Cartesius::Point.new(x: '3/4', y: -3))

      expect(parabola.to_equation).to eq('+2x^2 -3x -1y +4 = 0')
    end

  end


end

