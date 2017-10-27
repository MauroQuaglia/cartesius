require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/segment')

describe Cartesius::Segment do

  describe '.new' do

    describe 'point' do

      it 'should be reject' do
        expect {described_class.new(extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.origin)}.to raise_error(ArgumentError)
      end

    end

  end

  describe '#line' do

    it 'should get line which contains it' do
      segment = described_class.new(
          extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.new(x: 1, y: 1)
      )

      expect(segment.line == Cartesius::Line.ascending_bisector)
    end

  end

  describe '#extremes' do

    it 'should get the extremes' do
      segment = described_class.new(
          extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.new(x: 1, y: 1)
      )

      expect(segment.extremes.first).to eq(Cartesius::Point.origin)
      expect(segment.extremes.last).to eq(Cartesius::Point.new(x: 1, y: 1))
    end

  end

  describe '#==' do

    it 'should be false when not segment' do
      segment = described_class.new(
          extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.new(x: -1, y: 1)
      )

      expect(segment == NilClass).to be_falsey
    end

    it 'should be false when different extremes' do
      segment1 = described_class.new(
          extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.new(x: -1, y: 1)
      )

      segment2 = described_class.new(
          extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.new(x: 1, y: -1)
      )

      expect(segment1 == segment2).to be_falsey
    end

    it 'should be true when same extremes' do
      segment1 = described_class.new(
          extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.new(x: 1, y: 1)
      )

      segment2 = described_class.new(
          extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.new(x: 1, y: 1)
      )

      segment3 = described_class.new(
          extreme1: Cartesius::Point.new(x: 1, y: 1), extreme2: Cartesius::Point.origin
      )

      expect(segment1 == segment2).to be_truthy
      expect(segment1 == segment3).to be_truthy
    end

  end

  describe '#congruent?' do

    it 'should be false when not segment' do
      segment = described_class.new(
          extreme1: Cartesius::Point.new(x: 0, y: 1), extreme2: Cartesius::Point.new(x: 1, y: 3)
      )

      expect(segment.congruent?(NilClass)).to be_falsey
    end

    it 'should be false when different length' do
      segment1 = described_class.new(
          extreme1: Cartesius::Point.new(x: 0, y: 0), extreme2: Cartesius::Point.new(x: 1, y: 1)
      )

      segment2 = described_class.new(
          extreme1: Cartesius::Point.new(x: 0, y: 0), extreme2: Cartesius::Point.new(x: 2, y: 2)
      )

      expect(segment1.congruent?(segment2)).to be_falsey
    end

    it 'should be true when same length' do
      segment1 = described_class.new(
          extreme1: Cartesius::Point.new(x: 0, y: 0), extreme2: Cartesius::Point.new(x: 1, y: 1)
      )

      segment2 = described_class.new(
          extreme1: Cartesius::Point.new(x: 0, y: 0), extreme2: Cartesius::Point.new(x: -1, y: -1)
      )

      expect(segment1.congruent?(segment2)).to be_truthy
    end

  end

  describe '#mid' do

    it 'should be the mid point' do
      segment = described_class.new(
          extreme1: Cartesius::Point.new(x: 0, y: 0), extreme2: Cartesius::Point.new(x: 2, y: 2)
      )

      expect(segment.mid).to eq(Cartesius::Point.new(x: 1, y: 1))
    end

  end

  describe '#length' do

    it 'should be positive' do
      segment = described_class.new(
          extreme1: Cartesius::Point.new(x: 0, y: 0), extreme2: Cartesius::Point.new(x: 3, y: 4)
      )

      expect(segment.length).to eq(5)
    end

  end


end