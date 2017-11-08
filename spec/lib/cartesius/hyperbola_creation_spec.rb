require_relative('../../spec_helper')
require('cartesius/hyperbola')
require('cartesius/point')
require('cartesius/segment')

describe Cartesius::Hyperbola do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

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
        let(:distance) {8}

        it 'should be valid: x^2/16 - y^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 0, y: 5))
          expect(subject.focus2).to eq(point.new(x: 0, y: -5))
          expect(subject.distance).to eq(8)
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
        let(:distance) {8}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 1, y: 6))
          expect(subject.focus2).to eq(point.new(x: 1, y: -4))
          expect(subject.distance).to eq(8)
        end
      end

    end

  end

  describe '.by_canonical' do
    subject {described_class.by_canonical(transverse_axis: transverse_axis, not_transverse_axis: not_transverse_axis)}

    context 'bad parameters' do

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

      context 'when transverse axis and not transverse axis have different mid' do
        let(:transverse_axis) {segment.new(extreme1: point.new(x: -2, y: 0), extreme2: point.new(x: 2, y: 0))}
        let(:not_transverse_axis) {segment.new(extreme1: point.new(x: 0, y: -2), extreme2: point.new(x: 0, y: 1))}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Axes must be the same mid point!')
        end
      end


    end
  end
end

=begin
  describe '.by_canonical' do



    it 'should create a simple hyperbola with focus on x axis' do
      # x^2/16 - y^2/9 = 1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 4, not_transverse_axis: 3, position: 1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 5, y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -5, y: 0))
      expect(hyperbola.distance).to eq(8)
    end

    it 'should create a simple hyperbola with focus on y axis' do
      # x^2/16 - y^2/9 = -1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 3, not_transverse_axis: 4, position: -1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: 5))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -5))
      expect(hyperbola.distance).to eq(6)
    end

    it 'should create a general hyperbola with focus on x axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = 1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.new(x: 1, y: 1), transverse_axis: 4, not_transverse_axis: 3, position: 1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 6, y: 1))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -4, y: 1))
      expect(hyperbola.distance).to eq(8)
    end

    it 'should create a general hyperbola with focus on y axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = -1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.new(x: 1, y: 1), transverse_axis: 3, not_transverse_axis: 4, position: -1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 1, y: 6))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 1, y: -4))
      expect(hyperbola.distance).to eq(6)
    end

    it 'should create a simple equilateral hyperbola with focus on x axis' do
      # x^2 - y^2 = 1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 1, not_transverse_axis: 1, position: 1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: Math.sqrt(2), y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -Math.sqrt(2), y: 0))
      expect(hyperbola.distance).to eq(2)
    end

    it 'should create a simple equilateral hyperbola with focus on y axis' do
      # x^2 - y^2 = -1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 1, not_transverse_axis: 1, position: -1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: Math.sqrt(2)))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -Math.sqrt(2)))
      expect(hyperbola.distance).to eq(2)
    end

  end
=end

