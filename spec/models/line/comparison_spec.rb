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

  describe '#==?' do
    subject {line.x_axis == a_line}

    context 'with a non-line' do
      let(:a_line) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_line) {line.x_axis}

      it {is_expected.to be_truthy}
    end

    context 'when different slope' do
      let(:a_line) {line.ascending_bisector}

      it {is_expected.to be_falsey}
    end

    context 'when different known term' do
      let(:a_line) {line.horizontal(known_term: 1)}

      it {is_expected.to be_falsey}
    end

  end

end