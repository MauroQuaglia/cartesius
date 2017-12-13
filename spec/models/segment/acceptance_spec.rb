require_relative('../../spec_helper')

describe Cartesius::Segment do
  let(:point) {Cartesius::Point}
  let(:line) {Cartesius::Line}

  subject {described_class.new(extreme1: extreme1, extreme2: extreme2)}

  context 'on the x-axis' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: 1, y: 0)}

    it 'should be valid' do
      a_segment = described_class.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 1))

      expect(subject.extreme1).to eq(extreme1)
      expect(subject.extreme2).to eq(extreme2)
      expect(subject.horizontal?).to be_truthy
      expect(subject.vertical?).to be_falsey
      expect(subject.inclined?).to be_falsey
      expect(subject.ascending?).to be_falsey
      expect(subject.descending?).to be_falsey
      expect(subject.to_line).to eq(line.x_axis)
      expect(subject.length).to eq(1)
      expect(subject.mid).to eq(point.new(x: '1/2', y: 0))
      expect(subject.extremes).to eq([extreme1, extreme2])
      expect(subject.congruent?(a_segment)).to be_falsey
      expect(subject == a_segment).to be_falsey
    end
  end

  context 'on the y-axis' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: 0, y: 1)}

    it 'should be valid' do
      a_segment = described_class.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 1))

      expect(subject.extreme1).to eq(extreme1)
      expect(subject.extreme2).to eq(extreme2)
      expect(subject.horizontal?).to be_falsey
      expect(subject.vertical?).to be_truthy
      expect(subject.inclined?).to be_falsey
      expect(subject.ascending?).to be_falsey
      expect(subject.descending?).to be_falsey
      expect(subject.to_line).to eq(line.y_axis)
      expect(subject.length).to eq(1)
      expect(subject.mid).to eq(point.new(x: 0, y: '1/2'))
      expect(subject.extremes).to eq([extreme1, extreme2])
      expect(subject.congruent?(a_segment)).to be_falsey
      expect(subject == a_segment).to be_falsey
    end
  end

  context 'inclined' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: 1, y: 1)}

    it 'should be valid' do
      a_segment = described_class.new(extreme1: point.origin, extreme2: point.new(x: -1, y: -1))

      expect(subject.extreme1).to eq(extreme1)
      expect(subject.extreme2).to eq(extreme2)
      expect(subject.horizontal?).to be_falsey
      expect(subject.vertical?).to be_falsey
      expect(subject.inclined?).to be_truthy
      expect(subject.ascending?).to be_truthy
      expect(subject.descending?).to be_falsey
      expect(subject.to_line).to eq(line.ascending_bisector)
      expect(subject.length).to eq(Math.sqrt(2))
      expect(subject.mid).to eq(point.new(x: '1/2', y: '1/2'))
      expect(subject.extremes).to eq([extreme1, extreme2])
      expect(subject.congruent?(a_segment)).to be_truthy
      expect(subject == a_segment).to be_falsey
    end
  end

end