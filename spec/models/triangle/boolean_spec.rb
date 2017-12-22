require_relative('../../spec_helper')

describe Cartesius::Triangle do

  describe '#==' do
    subject {@triangle.new(
        a: @point.new(x: -1, y: 0),
        b: @point.new(x: 0, y: 1),
        c: @point.new(x: 1, y: 0)
    ) == a_triangle}

    context 'with a non-triangle' do
      let(:a_triangle) {NilClass}
      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: -1, y: 0),
          b: @point.new(x: 0, y: 1),
          c: @point.new(x: 1, y: 0)
      )}
      it {is_expected.to be_truthy}
    end

    context 'with same vertices' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: 1, y: 0),
          b: @point.new(x: 0, y: 1),
          c: @point.new(x: -1, y: 0)
      )}
      it {is_expected.to be_truthy}
    end

    context 'with different vertices' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: -1, y: 0),
          b: @point.new(x: 0, y: -1),
          c: @point.new(x: 1, y: 0)
      )}
      it {is_expected.to be_falsey}
    end
  end

  describe '#congruent?' do
    subject {@triangle.new(
        a: @point.new(x: -1, y: 0),
        b: @point.new(x: 0, y: 1),
        c: @point.new(x: 1, y: 0)
    ).congruent?(a_triangle)}

    context 'with a non-triangle' do
      let(:a_triangle) {NilClass}
      it {is_expected.to be_falsey}
    end

    context 'with itself' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: -1, y: 0),
          b: @point.new(x: 0, y: 1),
          c: @point.new(x: 1, y: 0)
      )}
      it {is_expected.to be_truthy}
    end

    context 'with same vertices' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: 1, y: 0),
          b: @point.new(x: 0, y: 1),
          c: @point.new(x: -1, y: 0)
      )}
      it {is_expected.to be_truthy}
    end

    context 'with different vertices' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: -1, y: 0),
          b: @point.new(x: 0, y: -1),
          c: @point.new(x: 1, y: 0)
      )}
      it {is_expected.to be_truthy}
    end

    context 'with itself translated' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: 0, y: 1),
          b: @point.new(x: 1, y: 2),
          c: @point.new(x: 2, y: 1)
      )}
      it {is_expected.to be_truthy}
    end
  end


end
