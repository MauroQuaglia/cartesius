require_relative('../../spec_helper')

describe 'Comparison of point' do

  describe '#congruent?' do
    subject {@point.origin.congruent?(a_point)}

    context 'with a non-point' do
      let(:a_point) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_point) {@point.origin}

      it {is_expected.to be_truthy}
    end

    context 'with not itself' do
      let(:a_point) {@point.new(x: 0, y: 1)}

      it {is_expected.to be_truthy}
    end

  end

  describe '#==' do
    subject {@point.origin == a_point}

    context 'with a non-point' do
      let(:a_point) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_point) {@point.origin}

      it {is_expected.to be_truthy}
    end

    context 'when approximately itself' do
      let(:a_point) {@point.new(x: Config::TOLERANCE / 2, y: Config::TOLERANCE / 3)}

      it {is_expected.to be_truthy}
    end

    context 'with different point' do
      let(:a_point) {@point.new(x: 0, y: 1)}

      it {is_expected.to be_falsey}
    end

  end

  describe '#eql?' do
    subject {@point.origin.eql?(a_point)}

    context 'with a non-point' do
      let(:a_point) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_point) {@point.origin}

      it {is_expected.to be_truthy}
    end

    context 'when approximately itself' do
      let(:a_point) {@point.new(x: Config::TOLERANCE / 2, y: Config::TOLERANCE / 3)}

      it {is_expected.to be_truthy}
    end

    context 'with different point' do
      let(:a_point) {@point.new(x: 0, y: 1)}

      it {is_expected.to be_falsey}
    end

  end

  describe '#origin?' do
    subject {a_point.origin?}

    context 'when origin' do
      let(:a_point) {@point.origin}

      it {is_expected.to be_truthy}
    end

    context 'when not origin' do
      let(:a_point) {@point.new(x: 0, y: 1)}

      it {is_expected.to be_falsey}
    end
  end

  describe '#horizontal?' do
    subject {@point.origin.horizontal?(a_point)}

    context 'when same y' do
      let(:a_point) {@point.new(x: 1, y: 0)}
      it {is_expected.to be_truthy}
    end

    context 'approximately same y' do
      let(:a_point) {@point.new(x: 1, y: Config::TOLERANCE / 2)}
      it {is_expected.to be_truthy}
    end

    context 'when different y' do
      let(:a_point) {@point.new(x: 1, y: 1)}
      it {is_expected.to be_falsey}
    end
  end

  describe '#vertical?' do
    subject {@point.origin.vertical?(a_point)}

    context 'when same x' do
      let(:a_point) {@point.new(x: 0, y: 1)}
      it {is_expected.to be_truthy}
    end

    context 'approximately same x' do
      let(:a_point) {@point.new(x: Config::TOLERANCE / 2, y: 1)}
      it {is_expected.to be_truthy}
    end

    context 'when different x' do
      let(:a_point) {@point.new(x: 1, y: 1)}
      it {is_expected.to be_falsey}
    end
  end


end
