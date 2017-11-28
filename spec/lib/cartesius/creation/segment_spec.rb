require_relative('../../../spec_helper')

describe Cartesius::Segment do
  let(:point) {Cartesius::Point}

  describe '.new' do

    describe 'point' do

      it 'should be reject' do
        expect {described_class.new(extreme1: point.origin, extreme2: point.origin)}.to raise_error(ArgumentError)
      end

    end

    describe 'segment' do

      it 'should be accept' do
        expect {described_class.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 1))}.not_to raise_error
      end

    end

  end

end