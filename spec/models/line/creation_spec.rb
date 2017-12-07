require_relative('../../spec_helper')

describe 'Creation of a line' do
  let(:line) {Cartesius::Line}

  describe '.new' do
    subject {line.new(x: x_coeff, y: y_coeff, k: known_term)}

    context 'equation 0 = 0' do
      let(:x_coeff) {0}
      let(:y_coeff) {0}
      let(:known_term) {0}

      it 'should be reject' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'equation 1 = 0' do
      let(:x_coeff) {0}
      let(:y_coeff) {0}
      let(:known_term) {1}

      it 'should be reject' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'equation x + y + 1 = 0' do
      let(:x_coeff) {1}
      let(:y_coeff) {1}
      let(:known_term) {1}

      it 'should be valid' do
        expect {subject}.not_to raise_error

        expect(subject.slope).to eq(-1)
        expect(subject.known_term).to eq(-1)
      end
    end
  end

  describe '.create' do
    subject {line.create(slope: slope, known_term: known_term)}

    context 'equation x + y + 1 = 0' do
      let(:slope) {-1}
      let(:known_term) {-1}

      it 'should be valid' do
        expect(subject.slope).to eq(-1)
        expect(subject.known_term).to eq(-1)
      end
    end
  end

  describe '.horizontal' do
    subject {line.horizontal(known_term: known_term)}

    context 'equation y + 1 = 0' do
      let(:known_term) {-1}

      it 'should be valid' do
        expect(subject.slope).to eq(0)
        expect(subject.known_term).to eq(-1)
      end
    end
  end

  describe '.vertical' do
    subject {line.vertical(known_term: known_term)}

    context 'equation x + 1 = 0' do
      let(:known_term) {-1}

      it 'should be valid' do
        expect(subject.slope).to eq(Float::INFINITY)
        expect(subject.known_term).to eq(-1)
      end
    end
  end

  describe '.x_axis' do
    subject {line.x_axis}

    context 'equation y = 0' do
      it 'should be valid' do
        expect(subject.slope).to eq(0)
        expect(subject.known_term).to eq(0)
      end
    end
  end

  describe '.y_axis' do
    subject {line.y_axis}

    context 'equation x = 0' do
      it 'should be valid' do
        expect(subject.slope).to eq(Float::INFINITY)
        expect(subject.known_term).to eq(0)
      end
    end
  end

  describe '.ascending_bisector' do
    subject {line.ascending_bisector}

    context 'equation y - x = 0' do
      it 'should be valid' do
        expect(subject.slope).to eq(1)
        expect(subject.known_term).to eq(0)
      end
    end
  end

  describe '.descending_bisector' do
    subject {line.descending_bisector}

    context 'equation y + x = 0' do
      it 'should be valid' do
        expect(subject.slope).to eq(-1)
        expect(subject.known_term).to eq(0)
      end
    end
  end

end