require_relative('../../spec_helper')
require('cartesius/segment')

describe Cartesius::Segment do

  describe '.new' do

    describe 'point' do

      it 'should be reject' do
        expect {described_class.new(extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.origin)}.to raise_error(ArgumentError)
      end

    end

    describe 'segment' do

      it 'should be accept' do
        expect {described_class.new(extreme1: Cartesius::Point.origin, extreme2: Cartesius::Point.new(x: 1, y: 1))}.not_to raise_error
      end

    end

  end

end