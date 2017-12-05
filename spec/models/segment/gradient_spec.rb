require_relative('../../spec_helper')

describe 'Gradient of a segment' do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

  subject {segment.new(extreme1: extreme1, extreme2: extreme2)}

  context 'when on x-axis' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: 1, y: 0)}

    it 'should be horizontal' do
      expect(subject.horizontal?).to be_truthy
      expect(subject.vertical?).to be_falsey
      expect(subject.inclined?).to be_falsey
      expect(subject.ascending?).to be_falsey
      expect(subject.descending?).to be_falsey
    end
  end

  context 'when on y-axis' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: 0, y: 1)}

    it 'should be vertical' do
      expect(subject.horizontal?).to be_falsey
      expect(subject.vertical?).to be_truthy
      expect(subject.inclined?).to be_falsey
      expect(subject.ascending?).to be_falsey
      expect(subject.descending?).to be_falsey
    end
  end

  context 'when on ascending bisector' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: 1, y: 1)}

    it 'should be ascending' do
      expect(subject.horizontal?).to be_falsey
      expect(subject.vertical?).to be_falsey
      expect(subject.inclined?).to be_truthy
      expect(subject.ascending?).to be_truthy
      expect(subject.descending?).to be_falsey
    end
  end

  context 'when on descending bisector' do
    let(:extreme1) {point.origin}
    let(:extreme2) {point.new(x: -1, y: 1)}

    it 'should be descending' do
      expect(subject.horizontal?).to be_falsey
      expect(subject.vertical?).to be_falsey
      expect(subject.inclined?).to be_truthy
      expect(subject.ascending?).to be_falsey
      expect(subject.descending?).to be_truthy
    end
  end

end