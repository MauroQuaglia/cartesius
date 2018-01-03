require_relative('../../spec_helper')

describe Cartesius::Angle do

  describe '.new' do
    subject {described_class.new}

    it 'should be private' do
      expect {subject}.to raise_error(NoMethodError)
    end
  end

  describe '.by_degrees' do
    subject {described_class.by_degrees(degrees)}

    context 'null angle' do
      let(:degrees) {0}
      it 'should be valid' do
        expect(subject.degrees).to eq(0)
        expect(subject.radiants).to eq(0)
      end
    end

    context '45 degree angle' do
      let(:degrees) {45}
      it 'should be valid' do
        expect(subject.degrees).to eq(45)
        expect(subject.radiants).to eq(0.785)
      end
    end

    context 'right angle' do
      let(:degrees) {90}
      it 'should be valid' do
        expect(subject.degrees).to eq(90)
        expect(subject.radiants).to eq(1.571)
      end
    end

    context 'flat angle' do
      let(:degrees) {180}
      it 'should be valid' do
        expect(subject.degrees).to eq(180)
        expect(subject.radiants).to eq(3.142)
      end
    end
  end

  describe '.by_radiants' do
    subject {described_class.by_radiants(radiants)}

    context 'null angle' do
      let(:radiants) {0}
      it 'should be valid' do
        expect(subject.radiants).to eq(0)
        expect(subject.degrees).to eq(0)
      end
    end

    context 'π/4 radiants angle' do
      let(:radiants) {Rational(Math::PI, 4)}
      it 'should be valid' do
        expect(subject.radiants).to eq(0.785)
        expect(subject.degrees).to eq(45)
      end
    end

    context 'right angle' do
      let(:radiants) {Rational(Math::PI, 2)}
      it 'should be valid' do
        expect(subject.degrees).to eq(90)
        expect(subject.radiants).to eq(1.571)
      end
    end

    context 'flat angle' do
      let(:radiants) {Math::PI}
      it 'should be valid' do
        expect(subject.radiants).to eq(3.142)
        expect(subject.degrees).to eq(180)
      end
    end
  end

  describe '.by_lines' do
    subject {described_class.by_lines(line1: line1, line2: line2)}

    context 'when lines are the same' do
      let(:line1) {@line.x_axis}
      let(:line2) {@line.x_axis}

      it 'should be reject' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when lines are parallel' do
      let(:line1) {@line.x_axis}
      let(:line2) {@line.horizontal(known_term: 1)}

      it 'should be reject' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when lines are perpendicular' do
      let(:line1) {@line.x_axis}
      let(:line2) {@line.y_axis}

      it 'should be return right angles' do
        expect(subject.first.congruent?(@angle.right)).to be_truthy
        expect(subject.last.congruent?(@angle.right)).to be_truthy
      end
    end

    context 'when lines are incident' do
      let(:line1) {@line.x_axis}
      let(:line2) {@line.descending_bisector}

      it 'should be return right angles' do
        expect(subject.first.congruent?(@angle.by_degrees(45))).to be_truthy
        expect(subject.last.congruent?(@angle.by_degrees(135))).to be_truthy
      end
    end
  end

  describe '.null' do
    subject {@angle.null}

    context 'null angle' do
      it 'should be valid' do
        expect(subject.degrees).to eq(0)
      end
    end
  end

  describe '.right' do
    subject {@angle.right}

    context 'right angle' do
      it 'should be valid' do
        expect(subject.degrees).to eq(90)
      end
    end
  end

  describe '.flat' do
    subject {@angle.flat}

    context 'flat angle' do
      it 'should be valid' do
        expect(subject.degrees).to eq(180)
      end
    end
  end

  describe '.full' do
    subject {@angle.full}

    context 'full angle' do
      it 'should be valid' do
        expect(subject.degrees).to eq(360)
      end
    end
  end

end