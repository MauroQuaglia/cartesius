require_relative('../../spec_helper')

describe Cartesius::Angle do

  describe '.new' do
    subject {described_class.new}

    it 'should be private' do
      expect {subject}.to raise_error(NoMethodError)
    end
  end

  xdescribe '.by_lines' do
    subject {described_class.by_lines(line1: line1, line2: line2, type: type)}

    context 'nil angle' do
      let(:line1) {Line.x_axis}
      let(:line2) {Line.horizontal(known_term: 1)}
      let(:type) {:any}

      it 'should be reject' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'null angle' do
      let(:line1) {Line.x_axis}
      let(:line2) {Line.x_axis}
      let(:type) {:acute}

      it 'should be valid' do
        expect(subject.degrees).to eq(0)
      end
    end

    context 'flat angle' do
      let(:line1) {Line.x_axis}
      let(:line2) {Line.x_axis}
      let(:type) {:obtuse}

      it 'should be valid' do
        expect(subject.degrees).to eq(180)
      end
    end

    context 'acute angle' do
      let(:line1) {Line.x_axis}
      let(:line2) {Line.ascending_bisector}
      let(:type) {:acute}

      it 'should be valid' do
        expect(subject.degrees).to eq(45)
      end
    end

    context 'right angle' do
      let(:line1) {Line.x_axis}
      let(:line2) {Line.y_axis}
      let(:type) {:right}

      it 'should be valid' do
        expect(subject.degrees).to eq(90)
      end
    end

    context 'obtuse angle' do
      let(:line1) {Line.x_axis}
      let(:line2) {Line.ascending_bisector}
      let(:type) {:obtuse}

      it 'should be valid' do
        expect(subject.degrees).to eq(135)
      end
    end


  end


end