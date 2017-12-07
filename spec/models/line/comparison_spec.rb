require_relative('../../spec_helper')

describe 'Comparison of line' do
  let(:line) {Cartesius::Line}

  describe '#congruent?' do
    subject {line.x_axis.congruent?(a_line)}

    context 'with a non-line' do
      let(:a_line) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_line) {line.x_axis}

      it {is_expected.to be_truthy}
    end

    context 'with not itself' do
      let(:a_line) {line.y_axis}

      it {is_expected.to be_truthy}
    end

  end

  describe '#==' do
    subject {line.x_axis == a_line}

    context 'with a non-line' do
      let(:a_line) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_line) {line.x_axis}

      it {is_expected.to be_truthy}
    end

    context 'when different slope (same known term)' do
      let(:a_line) {line.ascending_bisector}

      it {is_expected.to be_falsey}
    end

    context 'when different known term (same slope)' do
      let(:a_line) {line.horizontal(known_term: 1)}

      it {is_expected.to be_falsey}
    end

  end

  describe '#parallel?' do

    context 'when x-axis' do
      subject {line.x_axis}

      it 'should be parallel' do
        expect(subject.parallel?(line.x_axis)).to be_truthy
        expect(subject.parallel?(line.horizontal(known_term: 1))).to be_truthy
        expect(subject.parallel?(line.y_axis)).to be_falsey
      end
    end

    context 'when y-axis' do
      subject {line.y_axis}

      it 'should be parallel' do
        expect(subject.parallel?(line.y_axis)).to be_truthy
        expect(subject.parallel?(line.vertical(known_term: 1))).to be_truthy
        expect(subject.parallel?(line.x_axis)).to be_falsey
      end
    end

    context 'when ascending bisector' do
      subject {line.ascending_bisector}

      it 'should be parallel' do
        expect(subject.parallel?(line.ascending_bisector)).to be_truthy
        expect(subject.parallel?(line.create(slope: 1, known_term: 1))).to be_truthy
        expect(subject.parallel?(line.descending_bisector)).to be_falsey
      end
    end

  end

  describe '#perpendicular?' do

    context 'when x-axis' do
      subject {line.x_axis}

      it 'should be perpendicular' do
        expect(subject.perpendicular?(line.x_axis)).to be_falsey
        expect(subject.perpendicular?(line.y_axis)).to be_truthy
        expect(subject.perpendicular?(line.ascending_bisector)).to be_falsey
      end
    end

    context 'when y-axis' do
      subject {line.y_axis}

      it 'should be parallel' do
        expect(subject.perpendicular?(line.y_axis)).to be_falsey
        expect(subject.perpendicular?(line.x_axis)).to be_truthy
        expect(subject.perpendicular?(line.ascending_bisector)).to be_falsey
      end
    end

    context 'when ascending bisector' do
      subject {line.ascending_bisector}

      it 'should be parallel' do
        expect(subject.perpendicular?(line.ascending_bisector)).to be_falsey
        expect(subject.perpendicular?(line.descending_bisector)).to be_truthy
        expect(subject.perpendicular?(line.x_axis)).to be_falsey
      end
    end

  end

end
