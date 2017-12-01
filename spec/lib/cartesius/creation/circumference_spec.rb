require_relative('../../../spec_helper')

describe Cartesius::Circumference do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

  describe '.new' do

    describe 'empty set' do

      it 'should reject a simple equation' do
        # x^2 + y^2 = -1 --> x^2 + y^2 + 1 = 0
        expect {described_class.new(x: 0, y: 0, k: 1)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 = -1 --> x^2 + y^2 + 2x - 2y + 3 = 0
        expect {described_class.new(x: 2, y: -2, k: 3)}.to raise_error(ArgumentError)
      end

    end

    describe 'point' do

      it 'should reject a simple equation' do
        # x^2 + y^2 = 0
        expect {described_class.new(x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 0 --> x^2 + y^2 + 2x - 2y + 2 = 0
        expect {described_class.new(x: 2, y: -2, k: 2)}.to raise_error(ArgumentError)
      end

    end

    describe 'circumference' do

      it 'should accept a simple equation' do
        # x^2 + y^2 = 1 --> x^2 + y^2 - 1 = 0
        expect {described_class.new(x: 0, y: 0, k: -1)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 1 --> x^2 + y^2 + 2x - 2y + 1 = 0
        expect {described_class.new(x: 2, y: -2, k: 1)}.not_to raise_error
      end

    end

  end

  describe '.by_definition' do
    subject {described_class.by_definition(center: center, radius: radius)}

    context 'bad parameters' do

      context 'when radius is not positive' do
        let(:center) {point.origin}
        let(:radius) {0}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Radius must be positive!')
        end
      end

    end

    context 'good parameters' do

      context 'when center in origin' do
        let(:center) {point.origin}
        let(:radius) {1}

        it 'should be valid: x^2 + y^2 = 1' do
          expect(subject.center).to eq(point.origin)
          expect(subject.radius).to eq(1)
        end
      end

      context 'when center not in origin' do
        let(:center) {point.new(x: 1, y: 1)}
        let(:radius) {1}

        it 'should be valid: (x - 1)^2 + (y - 1)^2 = 1' do
          expect(subject.center).to eq(point.new(x: 1, y: 1))
          expect(subject.radius).to eq(1)
        end
      end

    end

  end

  describe '.by_diameter' do
    subject {described_class.by_diameter(diameter: diameter)}

    context 'when center in origin' do
      let(:diameter) {segment.new(extreme1: point.new(x: -1, y: 0), extreme2: point.new(x: 1, y: 0))}

      it 'should be valid: x^2 + y^2 = 1' do
        expect(subject.center).to eq(point.origin)
        expect(subject.radius).to eq(1)
      end
    end

    context 'when center not in origin' do
      let(:diameter) {segment.new(extreme1: point.new(x: 1, y: 2), extreme2: point.new(x: 1, y: 0))}
      let(:radius) {1}

      it 'should be valid: (x - 1)^2 + (y - 1)^2 = 1' do
        expect(subject.center).to eq(point.new(x: 1, y: 1))
        expect(subject.radius).to eq(1)
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
          expect {subject}.to raise_error(ArgumentError, 'Invalid points!')
        end
      end

      context 'when points are aligned' do
        let(:point1) {point.new(x: -1, y: 0)}
        let(:point2) {point.origin}
        let(:point3) {point.new(x: 1, y: 0)}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Invalid points!')
        end
      end

    end

    context 'good parameters' do

      context 'when center in origin' do
        let(:point1) {point.new(x: -1, y: 0)}
        let(:point2) {point.new(x: 0, y: -1)}
        let(:point3) {point.new(x: 1, y: 0)}

        it 'should be valid: x^2 + y^2 = 1' do
          expect(subject.center).to eq(point.origin)
          expect(subject.radius).to eq(1)
        end
      end

      context 'when center not in origin' do
        let(:point1) {point.new(x: 0, y: 1)}
        let(:point2) {point.new(x: 1, y: 0)}
        let(:point3) {point.new(x: 2, y: 1)}

        it 'should be valid: (x - 1)^2 + (y - 1)^2 = 1' do
          expect(subject.center).to eq(point.new(x: 1, y: 1))
          expect(subject.radius).to eq(1)
        end
      end

    end
  end

  describe '.goniometric' do

    it 'should be valid: x^2 + y^2 = 1' do
      subject = described_class.goniometric
      expect(subject.center).to eq(point.origin)
      expect(subject.radius).to eq(1)
    end

  end

end
