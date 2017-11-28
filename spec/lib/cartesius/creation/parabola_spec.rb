require_relative('../../../spec_helper')
require('cartesius/parabola')

describe Cartesius::Parabola do
  let(:point) {Cartesius::Point}
  let(:line) {Cartesius::Line}

  describe '.new' do

    describe 'line' do

      it 'should reject a simple equation' do
        # y = 0
        expect {described_class.new(x2: 0, x: 0, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # y = x + 1 --> x - y + 1 = 0
        expect {described_class.new(x2: 0, x: 1, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'parabola' do

      it 'should accept a simple equation' do
        # y = x^2 --> x^2 - y = 0
        expect {described_class.new(x2: 1, x: 0, k: 0)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # y = x^2 + x + 1 --> x^2 + x - y + 1 = 0
        expect {described_class.new(x2: 1, x: 1, k: 1)}.not_to raise_error
      end

    end

  end

  describe '.by_definition' do
    subject {described_class.by_definition(directrix: directrix, focus: focus)}

    context 'bad parameters' do

      context 'when focus belongs to directrix' do
        let(:directrix) {line.x_axis}
        let(:focus) {point.origin}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Focus belongs to directrix!')
        end
      end

      context 'when directrix is not parallel to x-axis' do
        let(:directrix) {line.ascending_bisector}
        let(:focus) {point.new(x: -1, y: 1)}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Directrix is not parallel to x-axis!')
        end
      end

    end

    context 'good parameters' do

      context 'the simplest convex parabola' do
        let(:directrix) {line.new(x: 0, y: 1, k: '1/4')}
        let(:focus) {point.new(x: 0, y: '1/4')}

        it 'should be valid: x^2 - y = 0' do
          expect(subject.directrix).to eq(line.new(x: 0, y: 1, k: '1/4'))
          expect(subject.focus).to eq(point.new(x: 0, y: '1/4'))
        end
      end

      context 'the simplest concave parabola' do
        let(:directrix) {line.new(x: 0, y: 1, k: '-1/4')}
        let(:focus) {point.new(x: 0, y: '-1/4')}

        it 'should be valid: x^2 + y = 0' do
          expect(subject.directrix).to eq(line.new(x: 0, y: 1, k: '-1/4'))
          expect(subject.focus).to eq(point.new(x: 0, y: '-1/4'))
        end
      end

      context 'the generic convex parabola' do
        let(:directrix) {line.new(x: 0, y: 1, k: '-3/4')}
        let(:focus) {point.new(x: 1, y: '5/4')}

        it 'should be valid: x^2 -2x -y +2 = 0' do
          expect(subject.directrix).to eq(line.new(x: 0, y: 1, k: '-3/4'))
          expect(subject.focus).to eq(point.new(x: 1, y: '5/4'))
        end
      end


    end
  end

  describe '.by_points' do
    subject {described_class.by_points(point1: point1, point2: point2, point3: point3)}

    context 'bad parameters' do

      context 'when points are not distinct' do
        let(:point1) {point.origin}
        let(:point2) {point.origin}
        let(:point3) {point.origin}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Points must be different!')
        end
      end

    end

    context 'good parameters' do

      context 'the simplest convex parabola' do
        let(:point1) {point.new(x: -1, y: 1)}
        let(:point2) {point.origin}
        let(:point3) {point.new(x: 1, y: 1)}

        it 'should be valid: x^2 - y = 0' do
          expect(subject.directrix).to eq(line.new(x: 0, y: 1, k: '1/4'))
          expect(subject.focus).to eq(point.new(x: 0, y: '1/4'))
        end
      end

      context 'the simplest concave parabola' do
        let(:point1) {point.new(x: -1, y: -1)}
        let(:point2) {point.origin}
        let(:point3) {point.new(x: 1, y: -1)}

        it 'should be valid: x^2 + y = 0' do
          expect(subject.directrix).to eq(line.new(x: 0, y: 1, k: '-1/4'))
          expect(subject.focus).to eq(point.new(x: 0, y: '-1/4'))
        end
      end

      context 'the generic convex parabola' do
        let(:point1) {point.new(x: 0, y: 2)}
        let(:point2) {point.new(x: 1, y: 1)}
        let(:point3) {point.new(x: 2, y: 2)}

        it 'should be valid: x^2 -2x -y +2 = 0' do
          expect(subject.directrix).to eq(line.new(x: 0, y: 1, k: '-3/4'))
          expect(subject.focus).to eq(point.new(x: 1, y: '5/4'))
        end
      end


    end

  end
end