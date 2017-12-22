require_relative('../../spec_helper')

describe Cartesius::Triangle do
  let(:point) {Cartesius::Point}

  describe '.new' do
    subject {described_class.new(a: vertex1, b: vertex2, c: vertex3)}

    context 'same vertices' do
      let(:vertex1) {point.origin}
      let(:vertex2) {point.origin}
      let(:vertex3) {point.new(x: 1, y: 1)}

      it 'should be reject' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'aligned vertices' do
      let(:vertex1) {point.new(x: -1, y: 0)}
      let(:vertex2) {point.origin}
      let(:vertex3) {point.new(x: 1, y: 0)}

      it 'should be reject' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'valid vertices' do
      let(:vertex1) {point.new(x: -1, y: 0)}
      let(:vertex2) {point.new(x: 0, y: 1)}
      let(:vertex3) {point.new(x: 1, y: 0)}

      it 'should be valid' do
        vertices = subject.vertices
        expect(vertices[:a]).to eq(vertex1)
        expect(vertices[:b]).to eq(vertex2)
        expect(vertices[:c]).to eq(vertex3)
      end
    end
  end

end