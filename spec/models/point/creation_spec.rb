require_relative('../../spec_helper')

describe 'Creation of a point' do
  let(:point) {Cartesius::Point}

  describe '.new' do
    subject {point.new(x: x, y: y)}

    context 'origin' do
      let(:x) {0}
      let(:y) {0}

      it 'should be valid' do
        expect(subject.x).to eq(0)
        expect(subject.y).to eq(0)
      end
    end

    context 'generic point' do
      let(:x) {'-1/2'}
      let(:y) {3}

      it 'should be valid' do
        expect(subject.x).to eq(Rational(-1, 2))
        expect(subject.y).to eq(3)
      end
    end
  end

  describe '.origin' do
    subject {point.origin}

    it 'should be valid' do
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(0)
    end
  end

end