require_relative('../../spec_helper')

describe Cartesius::Circumference do

  describe 'congruent?' do

    # x^2 + y^2 = 1 --> x^2 + y^2 - 1 = 0
    let(:circumference) {
      described_class.new(x: 0, y: 0, k: -1)
    }

    it 'should be false when not circumference' do
      expect(circumference.congruent?(NilClass)).to be_falsey
    end

    it 'should be false when different radius' do
      # x^2 + y^2 = 2 --> x^2 + y^2 - 2 = 0
      circumference1 = described_class.new(x: 0, y: 0, k: -2)

      expect(circumference.congruent?(circumference1)).to be_falsey
    end

    it 'should be true when same radius' do
      # (x - 1)^2 + (y - 1)^2 = 1 --> x^2 + y^2 -2x -2y +1 = 0
      circumference1 = described_class.new(x: -2, y: -2, k: 1)

      expect(circumference.congruent?(circumference1)).to be_truthy
    end

  end

  describe '==?' do

    # x^2 + y^2 = 1 --> x^2 + y^2 - 1 = 0
    let(:circumference) {
      described_class.new(x: 0, y: 0, k: -1)
    }

    it 'should be false when not circumference' do
      expect(circumference == NilClass).to be_falsey
    end

    it 'should be false when different radius' do
      # x^2 + y^2 = 2 --> x^2 + y^2 - 2 = 0
      circumference1 = described_class.new(x: 0, y: 0, k: -2)

      expect(circumference == circumference1).to be_falsey
    end

    it 'should be false when traslated' do
      # (x - 1)^2 + (y - 1)^2 = 1 --> x^2 + y^2 -2x -2y +1 = 0
      circumference1 = described_class.new(x: -2, y: -2, k: 1)

      expect(circumference == circumference1).to be_falsey
    end

    it 'should be true' do
      # x^2 + y^2 = 1 --> x^2 + y^2 - 1 = 0
      circumference1 = described_class.new(x: 0, y: 0, k: -1)

      expect(circumference == circumference1).to be_truthy
    end

  end
end