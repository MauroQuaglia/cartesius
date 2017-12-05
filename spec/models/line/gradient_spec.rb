require_relative('../../spec_helper')

describe 'Gradient of a line' do
  let(:line) {Cartesius::Line}

  context 'when x-axis' do
    subject {line.x_axis}

    it 'should be horizontal' do
      expect(subject.horizontal?).to be_truthy
      expect(subject.vertical?).to be_falsey
      expect(subject.inclined?).to be_falsey
      expect(subject.ascending?).to be_falsey
      expect(subject.descending?).to be_falsey
    end
  end

  context 'when y-axis' do
    subject {line.y_axis}

    it 'should be vertical' do
      expect(subject.horizontal?).to be_falsey
      expect(subject.vertical?).to be_truthy
      expect(subject.inclined?).to be_falsey
      expect(subject.ascending?).to be_falsey
      expect(subject.descending?).to be_falsey
    end
  end

  context 'when ascending bisector' do
    subject {line.ascending_bisector}

    it 'should be ascending' do
      expect(subject.horizontal?).to be_falsey
      expect(subject.vertical?).to be_falsey
      expect(subject.inclined?).to be_truthy
      expect(subject.ascending?).to be_truthy
      expect(subject.descending?).to be_falsey
    end
  end

  context 'when on descending bisector' do
    subject {line.descending_bisector}

    it 'should be descending' do
      expect(subject.horizontal?).to be_falsey
      expect(subject.vertical?).to be_falsey
      expect(subject.inclined?).to be_truthy
      expect(subject.ascending?).to be_falsey
      expect(subject.descending?).to be_truthy
    end
  end

end