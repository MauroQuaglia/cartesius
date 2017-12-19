require_relative('../../spec_helper')

describe 'Comparison of point' do
  let(:point) {Cartesius::Point}

  describe '#congruent?' do
    subject {point.origin.congruent?(a_point)}

    context 'with a non-point' do
      let(:a_point) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_point) {point.origin}

      it {is_expected.to be_truthy}
    end

    context 'with not itself' do
      let(:a_point) {point.new(x: 0, y: 1)}

      it {is_expected.to be_truthy}
    end

  end

  describe '#==' do
    subject {point.origin == a_point}

    context 'with a non-point' do
      let(:a_point) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_point) {point.origin}

      it {is_expected.to be_truthy}
    end

    context 'with different point' do
      let(:a_point) {point.new(x: 0, y: 1)}

      it {is_expected.to be_falsey}
    end

  end

  describe '#eql?' do
    subject {point.origin.eql?(a_point)}

    context 'with a non-point' do
      let(:a_point) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_point) {point.origin}

      it {is_expected.to be_truthy}
    end

    context 'with different point' do
      let(:a_point) {point.new(x: 0, y: 1)}

      it {is_expected.to be_falsey}
    end

  end

  describe '#origin?' do
    subject {a_point.origin?}

    context 'when origin' do
      let(:a_point) {point.origin}

      it {is_expected.to be_truthy}
    end

    context 'when not origin' do
      let(:a_point) {point.new(x: 0, y: 1)}

      it {is_expected.to be_falsey}
    end
  end

end
