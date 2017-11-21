require_relative('../../spec_helper')
require('cartesius/ellipse')
require('cartesius/point')

describe Cartesius::Ellipse do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

  describe '.new old' do

    describe 'empty set' do

      it 'should reject a simple equation' do
        # x^2 + y^2 / 2 = -1 --> 2x^2 + y^2 + 2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: 2)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = -1 --> 2x^2 + y^2 + 4x -2y + 5 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 5)}.to raise_error(ArgumentError)
      end

    end

    describe 'point' do

      it 'should reject a simple equation' do
        # x^2 + y^2 / 2 = 0 --> 2x^2 + y^2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = 0 --> 2x^2 + y^2 + 4x -2y + 3 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 3)}.to raise_error(ArgumentError)
      end

    end

    describe 'line' do

      it 'should reject a simple equation' do
        # y = 0
        expect {described_class.new(x2: 0, y2: 0, x: 0, y: 1, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # y = -x - 1 --> x + y + 1 = 0
        expect {described_class.new(x2: 0, y2: 0, x: 1, y: 1, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'circumference' do

      it 'should reject a simple equation' do
        # x^2 + y^2 = 1 --> x^2 + y^2 - 1 = 0
        expect {described_class.new(x2: 1, y2: 1, x: 0, y: 0, k: -1)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 1 --> x^2 + y^2 + 2x - 2y + 1 = 0
        expect {described_class.new(x2: 1, y2: 1, x: 2, y: -2, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'ellipse' do

      it 'should accept a simple equation' do
        # x^2 + y^2 / 2 = 1 --> 2x^2 + y^2 - 2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: -2)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = 1 --> 2x^2 + y^2 + 4x - 2y + 1 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 1)}.not_to raise_error
      end

    end

    describe 'parabola' do

      it 'should reject a simple equation' do
        # y = x^2 --> x^2 - y = 0
        expect {described_class.new(x2: 1, y2: 0, x: 0, y: -1, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # y = x^2 + x + 1 --> x^2 + x - y + 1 = 0
        expect {described_class.new(x2: 1, y2: 0, x: 1, y: -1, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'hyperbola' do

      it 'should reject a simple equation' do
        # x^2 - y^2 / 2 = 1 --> 2x^2 - y^2 - 2 = 0
        expect {described_class.new(x2: 2, y2: -1, x: 0, y: 0, k: -2)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 - (y - 1)^2 / 2 = 1 --> 2x^2 - y^2 + 4x + 2y - 1 = 0
        expect {described_class.new(x2: 2, y2: -1, x: 4, y: 2, k: -1)}.to raise_error(ArgumentError)
      end

    end

    describe 'plane' do

      it 'should reject the equation' do
        # 0 = 0
        expect {described_class.new(x2: 0, y2: 0, x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

    end

  end

  describe '.by_definition' do
    subject {described_class.by_definition(focus1: focus1, focus2: focus2, distance: distance)}

    context 'bad parameters' do

      context 'when focus are the same' do
        let(:focus1) {point.origin}
        let(:focus2) {point.origin}
        let(:distance) {1}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Focus points must be different!')
        end
      end

      context 'when focal axis are inclined' do
        let(:focus1) {point.origin}
        let(:focus2) {point.new(x: 1, y: 1)}
        let(:distance) {2}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Focal axis must not be inclined!')
        end
      end

      context 'when difference between distances is not less than focal distance' do
        let(:focus1) {point.new(x: -1, y: 0)}
        let(:focus2) {point.new(x: 1, y: 0)}
        let(:distance) {2}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Sum of distances must be greater than focal distance!')
        end
      end

    end

    context 'good parameters' do

      context 'when focus on x axis' do
        let(:focus1) {point.new(x: 4, y: 0)}
        let(:focus2) {point.new(x: -4, y: 0)}
        let(:distance) {10}

        it 'should be valid: x^2/25 + y^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 4, y: 0))
          expect(subject.focus2).to eq(point.new(x: -4, y: 0))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when focus on y axis' do
        let(:focus1) {point.new(x: 0, y: 4)}
        let(:focus2) {point.new(x: 0, y: -4)}
        let(:distance) {10}

        it 'should be valid: x^2/9 + y^2/25 = 1' do
          expect(subject.focus1).to eq(point.new(x: 0, y: 4))
          expect(subject.focus2).to eq(point.new(x: 0, y: -4))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when focus parallel to x axis' do
        let(:focus1) {point.new(x: 5, y: 1)}
        let(:focus2) {point.new(x: -3, y: 1)}
        let(:distance) {10}

        it 'should be valid: (x - 1)^2/25 + (y - 1)^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 5, y: 1))
          expect(subject.focus2).to eq(point.new(x: -3, y: 1))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when focus parallel to y axis' do
        let(:focus1) {point.new(x: 1, y: 5)}
        let(:focus2) {point.new(x: 1, y: -3)}
        let(:distance) {10}

        it 'should be valid: (x - 1)^2/9 + (y - 1)^2/25 = 1' do
          expect(subject.focus1).to eq(point.new(x: 1, y: 5))
          expect(subject.focus2).to eq(point.new(x: 1, y: -3))
          expect(subject.distance).to eq(10)
        end
      end

    end
  end

  describe '.by_axes' do
    subject {described_class.by_axes(major_axis: major_axis, minor_axis: minor_axis)}

    context 'bad parameters' do

      context 'when axes are the same' do
        let(:major_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 2, y: 0))}
        let(:minor_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 2, y: 0))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must be different!')
        end
      end

      context 'when major axis is inclined' do
        let(:major_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 2, y: 2))}
        let(:minor_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 2, y: 0))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must not be inclined!')
        end
      end

      context 'when minor axis is inclined' do
        let(:major_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 2, y: 0))}
        let(:minor_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 1))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must not be inclined!')
        end
      end

      context 'when axes are horizontal' do
        let(:major_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 4, y: 0))}
        let(:minor_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 2, y: 0))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes can not be both horizontal!')
        end
      end

      context 'when axes are vertical' do
        let(:major_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 0, y: 4))}
        let(:minor_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 0, y: 2))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes can not be both vertical!')
        end
      end

      context 'when major axis and minor axis have different mid' do
        let(:major_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 4, y: 0))}
        let(:minor_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 0, y: 4))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must be the same mid point!')
        end
      end

    end

    context 'good parameters' do

      context 'when focus on x axis' do
        let(:major_axis) {segment.new(extreme1: point.new(x: -5, y: 0), extreme2: point.new(x: 5, y: 0))}
        let(:minor_axis) {segment.new(extreme1: point.new(x: 0, y: -3), extreme2: point.new(x: 0, y: 3))}

        it 'should be valid: x^2/25 + y^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 4, y: 0))
          expect(subject.focus2).to eq(point.new(x: -4, y: 0))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when focus on y axis' do
        let(:major_axis) {segment.new(extreme1: point.new(x: 0, y: -5), extreme2: point.new(x: 0, y: 5))}
        let(:minor_axis) {segment.new(extreme1: point.new(x: -3, y: 0), extreme2: point.new(x: 3, y: 0))}

        it 'should be valid: x^2/9 + y^2/25 = 1' do
          expect(subject.focus1).to eq(point.new(x: 0, y: 4))
          expect(subject.focus2).to eq(point.new(x: 0, y: -4))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when foci parallel to x axis' do
        let(:major_axis) {segment.new(extreme1: point.new(x: -4, y: 1), extreme2: point.new(x: 6, y: 1))}
        let(:minor_axis) {segment.new(extreme1: point.new(x: 1, y: -2), extreme2: point.new(x: 1, y: 4))}

        it 'should be valid: (x - 1)^2/25 + (y - 1)^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 5, y: 1))
          expect(subject.focus2).to eq(point.new(x: -3, y: 1))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when foci parallel to y axis' do
        let(:major_axis) {segment.new(extreme1: point.new(x: 1, y: -4), extreme2: point.new(x: 1, y: 6))}
        let(:minor_axis) {segment.new(extreme1: point.new(x: -2, y: 1), extreme2: point.new(x: 4, y: 1))}

        it 'should be valid: (x - 1)^2/9 + (y - 1)^2/25 = 1' do
          expect(subject.focus1).to eq(point.new(x: 1, y: 5))
          expect(subject.focus2).to eq(point.new(x: 1, y: -3))
          expect(subject.distance).to eq(10)
        end
      end
    end
  end

  describe '.by_points' do
    subject {described_class.by_points(center: center, point1: point1, point2: point2)}

    context 'bad parameters' do

      context 'when points are not distinct' do
        let(:center) {point.origin}
        let(:point1) {point.origin}
        let(:point2) {point.origin}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Points must be different!')
        end
      end

      context 'points are not enough' do
        let(:center) {point.origin}
        let(:point1) {point.new(x: -4, y: 0)}
        let(:point2) {point.new(x: 4, y: 0)}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Center and points are not valid!')
        end
      end

      context 'points are not enough (traslated)' do
        let(:center) {point.new(x: 1, y: 1)}
        let(:point1) {point.new(x: -3, y: 1)}
        let(:point2) {point.new(x: 5, y: 1)}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Center and points are not valid!')
        end
      end
    end

    context 'good parameters' do

      context 'when focus on x axis' do
        let(:center) {point.origin}
        let(:point1) {point.new(x: -5, y: 0)}
        let(:point2) {point.new(x: 0, y: -3)}

        it 'should be valid: x^2/25 + y^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 4, y: 0))
          expect(subject.focus2).to eq(point.new(x: -4, y: 0))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when focus on y axis' do
        let(:center) {point.origin}
        let(:point1) {point.new(x: 0, y: 5)}
        let(:point2) {point.new(x: 3, y: 0)}

        it 'should be valid: x^2/9 + y^2/25 = 1' do
          expect(subject.focus1).to eq(point.new(x: 0, y: 4))
          expect(subject.focus2).to eq(point.new(x: 0, y: -4))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when foci parallel to x axis' do
        let(:center) {point.new(x: 1, y: 1)}
        let(:point1) {point.new(x: -4, y: 1)}
        let(:point2) {point.new(x: 1, y: -2)}

        it 'should be valid: (x - 1)^2/25 + (y - 1)^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 5, y: 1))
          expect(subject.focus2).to eq(point.new(x: -3, y: 1))
          expect(subject.distance).to eq(10)
        end
      end

      context 'when foci parallel to y axis' do
        let(:center) {point.new(x: 1, y: 1)}
        let(:point1) {point.new(x: 1, y: 6)}
        let(:point2) {point.new(x: 4, y: 1)}

        it 'should be valid: (x - 1)^2/9 + (y - 1)^2/25 = 1' do
          expect(subject.focus1).to eq(point.new(x: 1, y: 5))
          expect(subject.focus2).to eq(point.new(x: 1, y: -3))
          expect(subject.distance).to eq(10)
        end
      end

    end
  end

end