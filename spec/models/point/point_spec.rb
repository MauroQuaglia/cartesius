require_relative('../../spec_helper')

describe Cartesius::Point do
  let(:point) {described_class}

  describe '.distance' do
    subject {point.distance(point1, point2)}

    context 'from itself' do
      let(:point1) {point.origin}
      let(:point2) {point.origin}

      it {is_expected.to eq(0)}
    end

    context 'when different points' do
      let(:point1) {point.origin}
      let(:point2) {point.new(x: 1, y: 0)}

      it {is_expected.to eq(1)}
    end
  end

  describe '#to_coordinates' do
    subject {a_point.to_coordinates}

    context 'when origin' do
      let(:a_point) {point.origin}
      it {is_expected.to eq('(0; 0)')}
    end

    context 'when not origin' do
      let(:a_point) {point.new(x: '1/2', y: '-4/5')}
      it {is_expected.to eq('(1/2; -4/5)')}
    end
  end

  describe '#to_equation' do
    subject {a_point.to_equation}

    context 'when origin' do
      let(:a_point) {point.origin}
      it {is_expected.to eq('+1x^2 +1y^2 = 0')}
    end

    context 'when not origin' do
      let(:a_point) {point.new(x: 1, y: 1)}
      it {is_expected.to eq('+1x^2 +1y^2 -2x -2y +2 = 0')}
    end
  end

end


