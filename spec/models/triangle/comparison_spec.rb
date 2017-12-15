require_relative('../../spec_helper')

describe Cartesius::Triangle do
  let(:point) {Cartesius::Point}

  describe '#congruent?' do
    subject {described_class.new(
        vertex1: point.new(x: -1, y: 0), vertex2: point.new(x: 0, y: 1), vertex3: point.new(x: 1, y: 0)).congruent?(a_triangle)
    }

    context 'with a non-triangle' do
      let(:a_triangle) {NilClass}

      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_triangle) {
        described_class.new(vertex1: point.new(x: -1, y: 0), vertex2: point.new(x: 0, y: 1), vertex3: point.new(x: 1, y: 0))
      }

      it {is_expected.to be_truthy}
    end

    context 'with not itself' do
    end

  end


end
