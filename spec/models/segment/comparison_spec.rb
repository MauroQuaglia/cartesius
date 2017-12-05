require_relative('../../spec_helper')

describe 'Comparison of segment' do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

  describe '#congruent?' do
    subject {
      segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 0)).congruent?(a_segment)
    }

    context 'with a non-segment' do
      let(:a_segment) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_segment) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 0))}

      it {is_expected.to be_truthy}
    end

    context 'when same length' do
      let(:a_segment) {segment.new(extreme1: point.origin, extreme2: point.new(x: 0, y: 1))}

      it {is_expected.to be_truthy}
    end

    context 'when different length' do
      let(:a_segment) {segment.new(extreme1: point.origin, extreme2: point.new(x: 2, y: 0))}

      it {is_expected.to be_falsey}
    end

  end

  describe '#==?' do
    subject {
      segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 0)) == a_segment
    }

    context 'with a non-segment' do
      let(:a_segment) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_segment) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 0))}

      it {is_expected.to be_truthy}
    end

    context 'when same extremes' do
      let(:a_segment) {segment.new(extreme1: point.new(x: 1, y: 0), extreme2: point.origin)}

      it {is_expected.to be_truthy}
    end

    context 'when different extremes' do
      let(:a_segment) {segment.new(extreme1: point.origin, extreme2: point.new(x: 0, y: 1))}

      it {is_expected.to be_falsey}
    end

  end

end