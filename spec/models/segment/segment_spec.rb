require_relative('../../spec_helper')

describe Cartesius::Segment do
  let(:point) {Cartesius::Point}
  let(:line) {Cartesius::Line}
  let(:segment) {Cartesius::Segment}

  subject {segment.new(extreme1: extreme1, extreme2: extreme2)}

  describe '#to_line' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: 1, y: 0)}

    it 'should be a line' do
      expect(subject.to_line).to eq(line.x_axis)
    end
  end

  describe '#length' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: 1, y: 0)}

    it 'should be 1' do
      expect(subject.length).to eq(1)
    end
  end

  describe '#mid' do
    let(:extreme1) {point.new(x: -1, y: 0)}
    let(:extreme2) {point.new(x: 1, y: 0)}

    it 'should be the origin' do
      expect(subject.mid).to eq(point.origin)
    end
  end

  describe '#extremes' do
    let(:extreme1) {point.new(x: -1, y: -1)}
    let(:extreme2) {point.new(x: 1, y: 1)}

    it 'should be the extremes' do
      expect(subject.extremes).to eq([extreme1, extreme2])
    end
  end

end
