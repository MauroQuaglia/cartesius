require_relative('../../spec_helper')
require('cartesius/hyperbola')
require('cartesius/point')

describe Cartesius::Hyperbola do

  describe 'congruent?' do

    # x^2/16 - y^2/9 = 1
    let(:hyperbola) {
      described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: -144)
    }

    it 'should be false when not hyperbola' do
      expect(hyperbola.congruent?(NilClass)).to be_falsey
    end

    it 'should be false when different eccentricity' do
      # x^2/16 - y^2/9 = -1
      hyperbola1 = described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: 144)

      expect(hyperbola.congruent?(hyperbola1)).to be_falsey
    end

    it 'should be true when same eccentricity' do
      # (x - 1)^2/16 - (y - 1)^2/9 = 1
      hyperbola1 = described_class.new(x2: 9, y2: -16, x: -18, y: 32, k: -151)

      expect(hyperbola.congruent?(hyperbola1)).to be_truthy
    end

  end

  describe '==?' do

    # x^2/16 - y^2/9 = 1
    let(:hyperbola) {
      described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: -144)
    }

    it 'should be false when not hyperbola' do
      expect(hyperbola == NilClass).to be_falsey
    end

    it 'should be false when different eccentricity' do
      # x^2/16 - y^2/9 = -1
      hyperbola1 = described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: 144)

      expect(hyperbola == hyperbola1).to be_falsey
    end

    it 'should be false when traslated' do
      # (x - 1)^2/16 - (y - 1)^2/9 = 1
      hyperbola1 = described_class.new(x2: 9, y2: -16, x: -18, y: 32, k: -151)

      expect(hyperbola == hyperbola1).to be_falsey
    end

    it 'should be true' do
      # x^2/16 - y^2/9 = 1
      hyperbola1 =described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: -144)

      expect(hyperbola == hyperbola1).to be_truthy
    end

  end


end