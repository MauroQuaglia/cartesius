require_relative('../../spec_helper')

describe Cartesius::Line do
  let(:point) {Cartesius::Point}

  describe '#include?' do

    context 'when horizontal line' do
      subject {described_class.x_axis.include?(a_point)}

      context 'include a point' do
        let(:a_point) {point.origin}

        it {is_expected.to be_truthy}
      end

      context 'does not include a point' do
        let(:a_point) {point.new(x: 0, y: 1)}

        it {is_expected.to be_falsey}
      end
    end

    context 'when vertical line' do
      subject {described_class.y_axis.include?(a_point)}

      context 'include a point' do
        let(:a_point) {point.origin}

        it {is_expected.to be_truthy}
      end

      context 'does not include a point' do
        let(:a_point) {point.new(x: 1, y: 0)}

        it {is_expected.to be_falsey}
      end
    end

    context 'when inclined line' do
      subject {described_class.create(slope: 1, known_term: 1).include?(a_point)}

      context 'include a point' do
        let(:a_point) {point.new(x: 0, y: 1)}

        it {is_expected.to be_truthy}
      end

      context 'does not include a point' do
        let(:a_point) {point.new(x: 0, y: 2)}

        it {is_expected.to be_falsey}
      end
    end

  end

  describe '#x_intercept' do
    subject {a_line.x_intercept}

    context 'when x_axis' do
      let(:a_line) {described_class.x_axis}

      it {is_expected.to be_nil}
    end

    context 'when horizontal' do
      let(:a_line) {described_class.horizontal(known_term: 1)}

      it {is_expected.to be_nil}
    end

    context 'when vertical' do
      let(:a_line) {described_class.vertical(known_term: 1)}

      it {is_expected.to eq(1)}
    end

    context 'when inclined' do
      let(:a_line) {described_class.create(slope: 1, known_term: 1)}

      it {is_expected.to eq(-1)}
    end
  end

  describe '#y_intercept' do
    subject {a_line.y_intercept}

    context 'when y_axis' do
      let(:a_line) {described_class.y_axis}

      it {is_expected.to be_nil}
    end

    context 'when horizontal' do
      let(:a_line) {described_class.horizontal(known_term: 1)}

      it {is_expected.to eq(1)}
    end

    context 'when vertical' do
      let(:a_line) {described_class.vertical(known_term: 1)}

      it {is_expected.to be_nil}
    end

    context 'when inclined' do
      let(:a_line) {described_class.create(slope: 1, known_term: 1)}

      it {is_expected.to eq(1)}
    end
  end

  describe '#to_equation' do
    subject {a_line.to_equation}

    context 'when horizontal' do
      let(:a_line) {described_class.horizontal(known_term: 1)}

      it {is_expected.to eq('+1y -1 = 0')}
    end

    context 'when vertical' do
      let(:a_line) {described_class.vertical(known_term: 1)}

      it {is_expected.to eq('+1x -1 = 0')}
    end

    context 'when inclined' do
      let(:a_line) {described_class.create(slope: 1, known_term: 1)}

      it {is_expected.to eq('+1x -1y +1 = 0')}
    end
  end

  describe '#slope' do
    subject {a_line.slope}

    context 'should be horizontal' do
      let(:a_line) {described_class.horizontal(known_term: 1)}
      it {is_expected.to eq(0)}
    end

    context 'should be vertical' do
      let(:a_line) {described_class.vertical(known_term: 1)}
      it {is_expected.to eq(Float::INFINITY)}
    end

    context 'should be ascending' do
      let(:a_line) {described_class.create(slope: 1, known_term: 1)}
      it {is_expected.to eq(1)}
    end

    context 'should be descending' do
      let(:a_line) {described_class.create(slope: -1, known_term: 1)}
      it {is_expected.to eq(-1)}
    end

  end

  describe '#known_term' do
    subject {a_line.known_term}

    context 'should be positive' do
      let(:a_line) {described_class.vertical(known_term: 1)}
      it {is_expected.to eq(1)}
    end

    context 'should be zero' do
      let(:a_line) {described_class.x_axis}
      it {is_expected.to eq(0)}
    end

    context 'should be negative' do
      let(:a_line) {described_class.create(slope: 1, known_term: -1)}
      it {is_expected.to eq(-1)}
    end

  end

end
