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

  describe '#similar?' do
    subject {@triangle.new(
        a: @point.new(x: -1, y: 0),
        b: @point.new(x: 0, y: 1),
        c: @point.new(x: 1, y: 0)
    ).similar?(a_triangle)}

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

    context 'with same angles' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: 2, y: 0),
          b: @point.new(x: 0, y: -2),
          c: @point.new(x: -2, y: 0)
      )}
      it {is_expected.to be_truthy}
    end

    context 'with different angles' do
      let(:a_triangle) {@triangle.new(
          a: @point.new(x: -2, y: 0),
          b: @point.new(x: 0, y: -1),
          c: @point.new(x: 1, y: 0)
      )}
      it {is_expected.to be_falsey}
    end
  end

  describe 'angles properties' do

    context 'acute' do
      subject {@triangle.new(a: @point.new(x: -1, y: 0), b: @point.new(x: 0, y: 2), c: @point.new(x: 1, y: 0))}

      it 'should be acute' do
        expect(subject.acute?).to be_truthy
        expect(subject.rectangle?).to be_falsey
        expect(subject.obtuse?).to be_falsey
      end
    end

    context 'rectangle' do
      subject {@triangle.new(a: @point.new(x: -1, y: 0), b: @point.origin, c: @point.new(x: 0, y: 1))}

      it 'should be rectangle' do
        expect(subject.acute?).to be_falsey
        expect(subject.rectangle?).to be_truthy
        expect(subject.obtuse?).to be_falsey
      end
    end

    context 'obtuse' do
      subject {@triangle.new(a: @point.new(x: -2, y: 1), b: @point.origin, c: @point.new(x: 1, y: 0))}

      it 'should be obtuse' do
        expect(subject.acute?).to be_falsey
        expect(subject.rectangle?).to be_falsey
        expect(subject.obtuse?).to be_truthy
      end
    end

  end

  describe 'sides properties' do

    context 'equilateral' do
      subject {@triangle.new(
          a: @point.new(x: '-1/2', y: 0),
          b: @point.new(x: 0, y: Rational(Math.sqrt(3), 2)),
          c: @point.new(x: '1/2', y: 0))
      }

      it 'should be equilateral' do
        expect(subject.equilateral?).to be_truthy
        expect(subject.isosceles?).to be_truthy
        expect(subject.scalene?).to be_falsey
      end
    end

    context 'isosceles' do
      subject {@triangle.new(
          a: @point.new(x: -1, y: 0),
          b: @point.new(x: 0, y: 2),
          c: @point.new(x: 1, y: 0))
      }

      it 'should be isosceles' do
        expect(subject.equilateral?).to be_falsey
        expect(subject.isosceles?).to be_truthy
        expect(subject.scalene?).to be_falsey
      end
    end

    context 'scalene' do
      subject {@triangle.new(
          a: @point.new(x: -1, y: 0),
          b: @point.new(x: 0, y: 2),
          c: @point.new(x: 3, y: 0))
      }

      it 'should be scalene' do
        expect(subject.equilateral?).to be_falsey
        expect(subject.isosceles?).to be_falsey
        expect(subject.scalene?).to be_truthy
      end
    end

  end

end
