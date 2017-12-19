require_relative('../../spec_helper')

describe Cartesius::Triangle do
  let(:point) {Cartesius::Point}
  let(:triangle) {described_class}

  describe '#==' do
    subject {triangle.new(
        v1: point.new(x: -1, y: 0),
        v2: point.new(x: 0, y: 1),
        v3: point.new(x: 1, y: 0)
    ) == a_triangle}

    context 'with a non-triangle' do
      let(:a_triangle) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_triangle) {triangle.new(
          v1: point.new(x: -1, y: 0),
          v2: point.new(x: 0, y: 1),
          v3: point.new(x: 1, y: 0)
      )}

      it {is_expected.to be_truthy}
    end

    context 'with same vertices' do
      let(:a_triangle) {triangle.new(
          v1: point.new(x: 1, y: 0),
          v2: point.new(x: 0, y: 1),
          v3: point.new(x: -1, y: 0)
      )}

      it {is_expected.to be_truthy}
    end

    context 'with different vertices' do
      let(:a_triangle) {triangle.new(
          v1: point.new(x: -1, y: 0),
          v2: point.new(x: 0, y: -1),
          v3: point.new(x: 1, y: 0)
      )}

      it {is_expected.to be_falsey}
    end
  end

  describe '#congruent?' do
    subject {triangle.new(
        v1: point.new(x: -1, y: 0),
        v2: point.new(x: 0, y: 1),
        v3: point.new(x: 1, y: 0)
    ).congruent?(a_triangle)}

    context 'with a non-triangle' do
      let(:a_triangle) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_triangle) {triangle.new(
          v1: point.new(x: -1, y: 0),
          v2: point.new(x: 0, y: 1),
          v3: point.new(x: 1, y: 0)
      )}

      it {is_expected.to be_truthy}
    end

    context 'with same vertices' do
      let(:a_triangle) {triangle.new(
          v1: point.new(x: 1, y: 0),
          v2: point.new(x: 0, y: 1),
          v3: point.new(x: -1, y: 0)
      )}

      it {is_expected.to be_truthy}
    end

    context 'with different vertices' do
      let(:a_triangle) {triangle.new(
          v1: point.new(x: -1, y: 0),
          v2: point.new(x: 0, y: -1),
          v3: point.new(x: 1, y: 0)
      )}

      it {is_expected.to be_truthy}
    end

    context 'with itself translated' do
      let(:a_triangle) {triangle.new(
          v1: point.new(x: 0, y: 1),
          v2: point.new(x: 1, y: 2),
          v3: point.new(x: 2, y: 1)
      )}

      it {is_expected.to be_truthy}
    end

    context 'with a generic triangle' do
      let(:a_triangle) {triangle.new(
          v1: point.origin,
          v2: point.new(x: 1, y: 2),
          v3: point.new(x: 2, y: 1)
      )}

      it {is_expected.to be_falsey}
    end
  end


end
