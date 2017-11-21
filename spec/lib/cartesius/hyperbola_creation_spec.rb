require_relative('../../spec_helper')
require('cartesius/hyperbola')
require('cartesius/point')
require('cartesius/segment')

describe Cartesius::Hyperbola do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

  describe '.new' do

    it 'should be fail when coefficients are not valid' do
      expect {described_class.new(x2: 0, y2: -16, x: 0, y: 0, k: -144)}.to raise_error(ArgumentError, 'Invalid coefficients!')
      expect {described_class.new(x2: 9, y2: 0, x: 0, y: 0, k: -144)}.to raise_error(ArgumentError, 'Invalid coefficients!')

      expect {described_class.new(x2: 9, y2: 16, x: 0, y: 0, k: -144)}.to raise_error(ArgumentError, 'Invalid coefficients!')
      expect {described_class.new(x2: -9, y2: -16, x: 0, y: 0, k: 144)}.to raise_error(ArgumentError, 'Invalid coefficients!')

      expect {described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: 0)}.to raise_error(ArgumentError, 'Invalid coefficients!')
    end

    it 'should be valid: x^2/16 - y^2/9 = 1' do
      hyperbola = described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: -144)

      expect(hyperbola.focus1).to eq(point.new(x: 5, y: 0))
      expect(hyperbola.focus2).to eq(point.new(x: -5, y: 0))
      expect(hyperbola.distance).to eq(8)
    end

    it 'should be valid: x^2/16 - y^2/9 = -1' do
      hyperbola = described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: 144)

      expect(hyperbola.focus1).to eq(point.new(x: 0, y: 5))
      expect(hyperbola.focus2).to eq(point.new(x: 0, y: -5))
      expect(hyperbola.distance).to eq(6)
    end

    it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = 1' do
      hyperbola = described_class.new(x2: 9, y2: -16, x: -18, y: 32, k: -151)

      expect(hyperbola.focus1).to eq(point.new(x: 6, y: 1))
      expect(hyperbola.focus2).to eq(point.new(x: -4, y: 1))
      expect(hyperbola.distance).to eq(8)
    end

    it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = -1' do
      hyperbola = described_class.new(x2: 9, y2: -16, x: -18, y: 32, k: 137)

      expect(hyperbola.focus1).to eq(point.new(x: 1, y: 6))
      expect(hyperbola.focus2).to eq(point.new(x: 1, y: -4))
      expect(hyperbola.distance).to eq(6)
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
          expect {subject}.to raise_error(ArgumentError, 'Difference between distances must be less than focal distance!')
        end
      end

    end

    context 'good parameters' do

      context 'when focus on x axis' do
        let(:focus1) {point.new(x: 5, y: 0)}
        let(:focus2) {point.new(x: -5, y: 0)}
        let(:distance) {8}

        it 'should be valid: x^2/16 - y^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 5, y: 0))
          expect(subject.focus2).to eq(point.new(x: -5, y: 0))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus on y axis' do
        let(:focus1) {point.new(x: 0, y: 5)}
        let(:focus2) {point.new(x: 0, y: -5)}
        let(:distance) {6}

        it 'should be valid: x^2/16 - y^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 0, y: 5))
          expect(subject.focus2).to eq(point.new(x: 0, y: -5))
          expect(subject.distance).to eq(6)
        end
      end

      context 'when focus parallel to x axis' do
        let(:focus1) {point.new(x: 6, y: 1)}
        let(:focus2) {point.new(x: -4, y: 1)}
        let(:distance) {8}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 6, y: 1))
          expect(subject.focus2).to eq(point.new(x: -4, y: 1))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus parallel to y axis' do
        let(:focus1) {point.new(x: 1, y: 6)}
        let(:focus2) {point.new(x: 1, y: -4)}
        let(:distance) {6}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 1, y: 6))
          expect(subject.focus2).to eq(point.new(x: 1, y: -4))
          expect(subject.distance).to eq(6)
        end
      end

    end
  end

  describe '.by_axes' do
    subject {described_class.by_axes(transverse_axis: transverse_axis, not_transverse_axis: not_transverse_axis)}

    context 'bad parameters' do

      context 'when axes are the same' do
        let(:transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 1))}
        let(:not_transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 1))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must be different!')
        end
      end

      context 'when transverse axis is inclined' do
        let(:transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 1))}
        let(:not_transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 0))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must not be inclined!')
        end
      end

      context 'when not transverse axis is inclined' do
        let(:transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 0))}
        let(:not_transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 1))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must not be inclined!')
        end
      end

      context 'when axes are horizontal' do
        let(:transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 2, y: 0))}
        let(:not_transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: -2, y: 0))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes can not be both horizontal!')
        end
      end

      context 'when axes are vertical' do
        let(:transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 0, y: 2))}
        let(:not_transverse_axis) {segment.new(extreme1: point.origin, extreme2: point.new(x: 0, y: -2))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes can not be both vertical!')
        end
      end

      context 'when transverse axis and not transverse axis have different mid' do
        let(:transverse_axis) {segment.new(extreme1: point.new(x: -2, y: 0), extreme2: point.new(x: 2, y: 0))}
        let(:not_transverse_axis) {segment.new(extreme1: point.new(x: 0, y: -2), extreme2: point.new(x: 0, y: 1))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must be the same mid point!')
        end
      end

    end

    context 'good parameters' do

      context 'when focus on x axis' do
        let(:transverse_axis) {segment.new(extreme1: point.new(x: -4, y: 0), extreme2: point.new(x: 4, y: 0))}
        let(:not_transverse_axis) {segment.new(extreme1: point.new(x: 0, y: -3), extreme2: point.new(x: 0, y: 3))}

        it 'should be valid: x^2/16 - y^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 5, y: 0))
          expect(subject.focus2).to eq(point.new(x: -5, y: 0))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus on y axis' do
        let(:transverse_axis) {segment.new(extreme1: point.new(x: 0, y: -3), extreme2: point.new(x: 0, y: 3))}
        let(:not_transverse_axis) {segment.new(extreme1: point.new(x: -4, y: 0), extreme2: point.new(x: 4, y: 0))}

        it 'should be valid: x^2/16 - y^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 0, y: 5))
          expect(subject.focus2).to eq(point.new(x: 0, y: -5))
          expect(subject.distance).to eq(6)
        end
      end

      context 'when focus parallel to x axis' do
        let(:transverse_axis) {segment.new(extreme1: point.new(x: -3, y: 1), extreme2: point.new(x: 5, y: 1))}
        let(:not_transverse_axis) {segment.new(extreme1: point.new(x: 1, y: -2), extreme2: point.new(x: 1, y: 4))}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 6, y: 1))
          expect(subject.focus2).to eq(point.new(x: -4, y: 1))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus parallel to y axis' do
        let(:transverse_axis) {segment.new(extreme1: point.new(x: 1, y: -2), extreme2: point.new(x: 1, y: 4))}
        let(:not_transverse_axis) {segment.new(extreme1: point.new(x: -3, y: 1), extreme2: point.new(x: 5, y: 1))}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 1, y: 6))
          expect(subject.focus2).to eq(point.new(x: 1, y: -4))
          expect(subject.distance).to eq(6)
        end
      end

    end
  end

  describe '.by_points' do
    subject {described_class.by_points(center: center, vertex: vertex, point: point1)}

    context 'bad parameters' do

      context 'when points are not distinct' do
        let(:center) {point.origin}
        let(:vertex) {point.origin}
        let(:point1) {point.origin}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Points must be different!')
        end
      end

      context 'when center-vertex line is inclined' do
        let(:center) {point.origin}
        let(:vertex) {point.new(x: 1, y: 1)}
        let(:point1) {point.new(x: 2, y: 2)}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Vertex must be aligned with center!')
        end
      end

      context 'points are not enough' do
        let(:center) {point.origin}
        let(:vertex) {point.new(x: -4, y: 0)}
        let(:point1) {point.new(x: 4, y: 0)}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Center, vertex and point are not valid!')
        end
      end

    end

    context 'good parameters' do

      context 'when focus on x axis' do
        let(:center) {point.origin}
        let(:vertex) {point.new(x: 4, y: 0)}
        let(:point1) {point.new(x: 5, y: '9/4')}

        it 'should be valid: x^2/16 - y^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 5, y: 0))
          expect(subject.focus2).to eq(point.new(x: -5, y: 0))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus on y axis' do
        let(:center) {point.origin}
        let(:vertex) {point.new(x: 0, y: 3)}
        let(:point1) {point.new(x: '16/3', y: 5)}

        it 'should be valid: x^2/16 - y^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 0, y: 5))
          expect(subject.focus2).to eq(point.new(x: 0, y: -5))
          expect(subject.distance).to eq(6)
        end
      end

      context 'when focus parallel to x axis' do
        let(:center) {point.new(x: 1, y: 1)}
        let(:vertex) {point.new(x: 5, y: 1)}
        let(:point1) {point.new(x: 6, y: '13/4')}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 6, y: 1))
          expect(subject.focus2).to eq(point.new(x: -4, y: 1))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus parallel to y axis' do
        let(:center) {point.new(x: 1, y: 1)}
        let(:vertex) {point.new(x: 1, y: 4)}
        let(:point1) {point.new(x: '19/3', y: 6)}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 1, y: 6))
          expect(subject.focus2).to eq(point.new(x: 1, y: -4))
          expect(subject.distance).to eq(6)
        end
      end

    end
  end

end

