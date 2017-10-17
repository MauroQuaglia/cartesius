require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/circumference')
require_relative('../../../../lib/cartesius/models/point')

describe Conics::Circumference do

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

      expect(circumference.center).to eq(Conics::Point.origin)
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


end