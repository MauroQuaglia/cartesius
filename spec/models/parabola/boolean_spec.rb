require_relative('../../spec_helper')

describe Cartesius::Parabola do

  describe 'congruent?' do

    # y = x^2
    let(:parabola) {
      described_class.new(x2: 1, x: 0, k: 0)
    }

    it 'should be false when not parabola' do
      expect(parabola.congruent?(NilClass)).to be_falsey
    end

    it 'should be false when different eccentricity' do
      parabola1 = described_class.new(x2: 2, x: 0, k: 0)

      expect(parabola.congruent?(parabola1)).to be_falsey
    end

    it 'should be true when same eccentricity' do
      # x^2 -2x -y +2 = 0
      parabola1 = described_class.new(x2: 1, x: -2, k: 2)

      expect(parabola.congruent?(parabola1)).to be_truthy
    end

  end

  describe '==?' do

    # y = x^2
    let(:parabola) {
      described_class.new(x2: 1, x: 0, k: 0)
    }

    it 'should be false when not parabola' do
      expect(parabola == NilClass).to be_falsey
    end

    it 'should be false when different eccentricity' do
      parabola1 = described_class.new(x2: 2, x: 0, k: 0)

      expect(parabola == parabola1).to be_falsey
    end

    it 'should be false when traslated' do
      # x^2 -2x -y +2 = 0
      parabola1 = described_class.new(x2: 1, x: -2, k: 2)

      expect(parabola == parabola1).to be_falsey
    end

    it 'should be true' do
      parabola1 = described_class.new(x2: 1, x: 0, k: 0)

      expect(parabola == parabola1).to be_truthy
    end

  end

end

