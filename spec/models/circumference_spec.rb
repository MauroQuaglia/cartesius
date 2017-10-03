require_relative('../../spec/spec_helper')
require_relative('../../models/circumference')
require_relative('../../models/point')

describe Circumference do

  describe '.new' do

    context 'invalid parameters' do

      it 'should fail when empty set' do
        expect {
          described_class.new(x: 2, y: -2, k: 3)
        }.to raise_error(ArgumentError, 'Invalid coefficients!')
      end

      it 'should fail when point' do
        expect {
          described_class.new(x: 0, y: 0, k: 0)
        }.to raise_error(ArgumentError, 'Invalid coefficients!')
      end

    end

    it 'should be the simplest circumference' do
      circumference = described_class.new(x: 0, y: 0, k: -1)

      expect(circumference.center).to eq(Point.origin)
      expect(circumference.radius).to eq(1)
    end

    it 'should be a generic circumference' do
      circumference = described_class.new(x: -2, y: 2, k: -2)

      expect(circumference.center).to eq(Point.create(x: 1, y: -1))
      expect(circumference.radius).to eq(2)
    end

  end

  describe '.unitary'do

    it 'should be the unitary circumference' do
      circumference = described_class.unitary

      expect(circumference.center).to eq(Point.origin)
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

end