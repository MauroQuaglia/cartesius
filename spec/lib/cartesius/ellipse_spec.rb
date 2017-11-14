require_relative('../../spec_helper')
require('cartesius/ellipse')
require('cartesius/point')

describe Cartesius::Ellipse do

  describe 'congruent?' do

    let(:ellipse1) {
      described_class.by_definition(focus1: Cartesius::Point.new(x: 4, y: 0), focus2: Cartesius::Point.new(x: -4, y: 0), distance: 10)
    }

    it 'should be false when not ellipse' do
      expect(ellipse1.congruent?(NilClass)).to be_falsey
    end

    it 'should be false when different eccentricity' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.new(x: 3, y: 0), focus2: Cartesius::Point.new(x: -3, y: 0), distance: 10)

      expect(ellipse1.congruent?(ellipse2)).to be_falsey
    end

    it 'should be true when same eccentricity' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.new(x: 0, y: 4), focus2: Cartesius::Point.new(x: 0, y: -4), distance: 10)

      expect(ellipse1.congruent?(ellipse2)).to be_truthy
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