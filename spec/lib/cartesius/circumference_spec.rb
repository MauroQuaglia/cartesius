require_relative('../../spec_helper')
require('cartesius/circumference')
require('cartesius/point')

describe Cartesius::Circumference do


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

  describe '#congruent?' do

    it 'should not be congruent when not circumference' do
      circumference = described_class.by_definition(focus: Cartesius::Point.origin, radius: 1)

      expect(circumference.congruent?(Cartesius::Point.origin)).to be_falsey
    end

    it 'should not be congruent when different radius' do
      circumference1 = described_class.by_definition(focus: Cartesius::Point.origin, radius: 1)
      circumference2 = described_class.by_definition(focus: Cartesius::Point.origin, radius: 2)

      expect(
          circumference1.congruent?(circumference2)
      ).to be_falsey
    end

    it 'should be congruent' do
      circumference1 = described_class.by_definition(focus: Cartesius::Point.origin, radius: 1)
      circumference2 = described_class.by_definition(focus: Cartesius::Point.new(x: 1, y: 1), radius: 1)

      expect(
          circumference1.congruent?(circumference2)
      ).to be_truthy
    end

  end

end