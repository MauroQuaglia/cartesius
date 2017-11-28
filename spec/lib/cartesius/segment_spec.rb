require_relative('../../spec_helper')

describe Cartesius::Segment do
  let(:point) {Cartesius::Point}
  let(:line) {Cartesius::Line}

  describe '#to_line' do

    it 'should get line which contains it' do
      segment = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 1, y: 1)
      )

      expect(segment.to_line == line.ascending_bisector)
    end

  end

  describe 'gradient' do

    it 'should be horizontal' do
      segment = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 1, y: 0)
      )

      expect(segment.horizontal?).to be_truthy
      expect(segment.vertical?).to be_falsey
      expect(segment.inclined?).to be_falsey
      expect(segment.ascending?).to be_falsey
      expect(segment.descending?).to be_falsey
    end

    it 'should be vertical' do
      segment = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 0, y: 1)
      )

      expect(segment.horizontal?).to be_falsey
      expect(segment.vertical?).to be_truthy
      expect(segment.inclined?).to be_falsey
      expect(segment.ascending?).to be_falsey
      expect(segment.descending?).to be_falsey
    end

    it 'should be ascending' do
      segment = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 1, y: 1)
      )

      expect(segment.horizontal?).to be_falsey
      expect(segment.vertical?).to be_falsey
      expect(segment.inclined?).to be_truthy
      expect(segment.ascending?).to be_truthy
      expect(segment.descending?).to be_falsey
    end

    it 'should be descending' do
      segment = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: -1, y: 1)
      )

      expect(segment.horizontal?).to be_falsey
      expect(segment.vertical?).to be_falsey
      expect(segment.inclined?).to be_truthy
      expect(segment.ascending?).to be_falsey
      expect(segment.descending?).to be_truthy
    end
  end

  describe '#extremes' do

    it 'should get the extremes' do
      segment = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 1, y: 1)
      )

      expect(segment.extremes.first).to eq(point.origin)
      expect(segment.extremes.last).to eq(point.new(x: 1, y: 1))
    end

  end

  describe '#==' do

    it 'should be false when not segment' do
      segment = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: -1, y: 1)
      )

      expect(segment == NilClass).to be_falsey
    end

    it 'should be false when different extremes' do
      segment1 = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: -1, y: 1)
      )

      segment2 = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 1, y: -1)
      )

      expect(segment1 == segment2).to be_falsey
    end

    it 'should be true when same extremes' do
      segment1 = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 1, y: 1)
      )

      segment2 = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 1, y: 1)
      )

      segment3 = described_class.new(
          extreme1: point.new(x: 1, y: 1), extreme2: point.origin
      )

      expect(segment1 == segment2).to be_truthy
      expect(segment1 == segment3).to be_truthy
    end

  end

  describe '#congruent?' do

    it 'should be false when not segment' do
      segment = described_class.new(
          extreme1: point.new(x: 0, y: 1), extreme2: point.new(x: 1, y: 3)
      )

      expect(segment.congruent?(NilClass)).to be_falsey
    end

    it 'should be false when different length' do
      segment1 = described_class.new(
          extreme1: point.new(x: 0, y: 0), extreme2: point.new(x: 1, y: 1)
      )

      segment2 = described_class.new(
          extreme1: point.new(x: 0, y: 0), extreme2: point.new(x: 2, y: 2)
      )

      expect(segment1.congruent?(segment2)).to be_falsey
    end

    it 'should be true when same length' do
      segment1 = described_class.new(
          extreme1: point.new(x: 0, y: 0), extreme2: point.new(x: 1, y: 1)
      )

      segment2 = described_class.new(
          extreme1: point.new(x: 0, y: 0), extreme2: point.new(x: -1, y: -1)
      )

      expect(segment1.congruent?(segment2)).to be_truthy
    end

  end

  describe '#mid' do

    it 'should be the mid point' do
      segment = described_class.new(
          extreme1: point.new(x: 0, y: 0), extreme2: point.new(x: 2, y: 2)
      )

      expect(segment.mid).to eq(point.new(x: 1, y: 1))
    end

  end

  describe '#length' do

    it 'should be positive' do
      segment = described_class.new(
          extreme1: point.new(x: 0, y: 0), extreme2: point.new(x: 3, y: 4)
      )

      expect(segment.length).to eq(5)
    end

  end


end