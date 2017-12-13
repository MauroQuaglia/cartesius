require_relative('../../spec_helper')

describe 'Creation of a segment' do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

  describe '.new' do
    subject {segment.new(extreme1: extreme1, extreme2: extreme2)}

    context 'same extremes' do
      let(:extreme1) {point.origin}
      let(:extreme2) {point.origin}

      it 'should be reject' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'different extremes' do
      let(:extreme1) {point.origin}
      let(:extreme2) {point.new(x: 1, y: 0)}

      it 'should be valid' do
        expect(subject.extreme1).to eq(extreme1)
        expect(subject.extreme2).to eq(extreme2)
      end
    end
  end

end