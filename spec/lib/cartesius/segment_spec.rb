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

  describe '#extremes' do

    it 'should get the extremes' do
      segment = described_class.new(
          extreme1: point.origin, extreme2: point.new(x: 1, y: 1)
      )

      expect(segment.extremes.first).to eq(point.origin)
      expect(segment.extremes.last).to eq(point.new(x: 1, y: 1))
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