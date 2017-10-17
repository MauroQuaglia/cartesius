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

  
  describe '.unitary_convex' do

    it 'should be the unitary convex parabola' do
      parabola = described_class.unitary_convex

      expect(parabola.focus).to eq(Cartesius::Point.create(x: 0, y: '1/4'))
      expect(parabola.vertex).to eq(Cartesius::Point.origin)
      expect(parabola.directrix).to eq(Cartesius::Line.horizontal(known_term: '-1/4'))
      expect(parabola.symmetry_axis).to eq(Cartesius::Line.y_axis)
    end

  end

  describe '.unitary_concave' do

    it 'should be the unitary concave parabola' do
      parabola = described_class.unitary_concave

      expect(parabola.focus).to eq(Cartesius::Point.create(x: 0, y: '-1/4'))
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


end