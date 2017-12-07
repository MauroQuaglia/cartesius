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
        expect{subject}.to raise_error(ArgumentError)
      end
    end

    context 'equation 1 = 0' do
      let(:x_coeff) {0}
      let(:y_coeff) {0}
      let(:known_term) {1}

      it 'should be reject' do
        expect{subject}.to raise_error(ArgumentError)
      end
    end

    context 'equation x + y + 1 = 0' do
      let(:x_coeff) {1}
      let(:y_coeff) {1}
      let(:known_term) {1}

      it 'should be valid' do
        expect{subject}.not_to raise_error
      end
    end
  end


  
end