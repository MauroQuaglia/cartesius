require_relative('../../spec_helper')
require('cartesius/ellipse')
require('cartesius/point')

describe Cartesius::Ellipse do

  describe 'congruent?' do

    # x^2/25 + y^2/9 = 1 --> 9x^2 + 25y^2 - 225 = 0
    let(:ellipse) {
      described_class.new(x2: 9, y2: 25, x: 0, y: 0, k: -225)
    }

    it 'should be false when not ellipse' do
      expect(ellipse.congruent?(NilClass)).to be_falsey
    end

    it 'should be false when different eccentricity' do
      # x^2 + y^2/2 = 1 --> 2x^2 + y^2 - 2 = 0
      ellipse1 = described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: -2)

      expect(ellipse.congruent?(ellipse1)).to be_falsey
    end

    it 'should be true when same eccentricity' do
      # (x - 1)^2/25 + (y - 1)^2/9 = 1 --> 9x^2 + 25y^2 - 18x - 50y - 191 = 0
      ellipse1 = described_class.new(x2: 9, y2: 25, x: -18, y: -50, k: -191)

      expect(ellipse.congruent?(ellipse1)).to be_truthy
    end

    it 'should be true when same eccentricity (coefficients * 2)' do
      ellipse1 = described_class.new(x2: 18, y2: 50, x: 0, y: 0, k: -450)

      expect(ellipse.congruent?(ellipse1)).to be_truthy
    end

    it 'should be true when same eccentricity (coefficients * -2)' do
      ellipse1 = described_class.new(x2: -18, y2: -50, x: 0, y: 0, k: 450)

      expect(ellipse.congruent?(ellipse1)).to be_truthy
    end

  end

  describe '==?' do

    let(:ellipse1) {
      described_class.by_definition(focus1: Cartesius::Point.new(x: 4, y: 0), focus2: Cartesius::Point.new(x: -4, y: 0), distance: 10)
    }

    it 'should be false when not ellipse' do
      expect(ellipse1 == NilClass).to be_falsey
    end

    it 'should be false when different focus' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.new(x: 0, y: 4), focus2: Cartesius::Point.new(x: 0, y: -4), distance: 10)

      expect(ellipse1 == ellipse2).to be_falsey
    end

    it 'should be false when different distance' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.new(x: 4, y: 0), focus2: Cartesius::Point.new(x: -4, y: 0), distance: 20)

      expect(ellipse1 == ellipse2).to be_falsey
    end

    it 'should be true when same focus and distance' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.new(x: 4, y: 0), focus2: Cartesius::Point.new(x: -4, y: 0), distance: 10)

      expect(ellipse1 == ellipse2).to be_truthy
    end

    it 'should be true when equivalent (coefficients * 2)' do
      ellipse1 = described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 1)

      ellipse2 = described_class.new(x2: 4, y2: 2, x: 8, y: -4, k: 2)
      expect(ellipse1 == ellipse2).to be_truthy
    end

    it 'should be true when equivalent (coefficients * -2)' do
      ellipse1 = described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 1)

      ellipse2 = described_class.new(x2: -4, y2: -2, x: -8, y: 4, k: -2)
      expect(ellipse1 == ellipse2).to be_truthy
    end

  end

end