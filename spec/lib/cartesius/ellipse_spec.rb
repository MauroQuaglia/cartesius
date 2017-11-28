require_relative('../../spec_helper')

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

    # x^2/25 + y^2/9 = 1 --> 9x^2 + 25y^2 - 225 = 0
    let(:ellipse) {
      described_class.new(x2: 9, y2: 25, x: 0, y: 0, k: -225)
    }

    it 'should be false when not ellipse' do
      expect(ellipse == NilClass).to be_falsey
    end

    it 'should be false when different eccentricity' do
      # x^2 + y^2/2 = 1 --> 2x^2 + y^2 - 2 = 0
      ellipse1 = described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: -2)

      expect(ellipse == ellipse1).to be_falsey
    end

    it 'should be false when traslated' do
      # (x - 1)^2 / 25 + (y - 1)^2 / 9 = 1 --> 9x^2 + 25y^2 - 18x - 50y - 191 = 0
      ellipse1 = described_class.new(x2: 9, y2: 25, x: -18, y: -50, k: -191)

      expect(ellipse == ellipse1).to be_falsey
    end

    it 'should be true' do
      # x^2/25 + y^2/9 = 1 --> 9x^2 + 25y^2 - 225 = 0
      ellipse1 = described_class.new(x2: 9, y2: 25, x: 0, y: 0, k: -225)

      expect(ellipse == ellipse1).to be_truthy
    end

    it 'should be true (coefficients * 2)' do
      ellipse1 = described_class.new(x2: 18, y2: 50, x: 0, y: 0, k: -450)

      expect(ellipse == ellipse1).to be_truthy
    end

    it 'should be true (coefficients * -2)' do
      ellipse1 = described_class.new(x2: -18, y2: -50, x: 0, y: 0, k: 450)

      expect(ellipse == ellipse1).to be_truthy
    end

  end

end