require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/homography')

describe Cartesius::Homography do

  describe '.new' do

    describe 'line' do

      it 'should reject a general equation' do
        # (x + 1)(y - 1) = 0 --> xy - x + y - 1 = 0
        expect {described_class.new(x: -1, y: 1, k: -1)}.to raise_error(ArgumentError)
      end

    end

    describe 'homography' do

      it 'should accept a simple equation' do
        # xy = 1 --> xy - 1 = 0
        expect {described_class.new(x: 0, y: 0, k: 1)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # (x + 1)(y - 1) = -1 --> xy - x - y = 0
        expect {described_class.new(x: -1, y: -1, k: 0)}.not_to raise_error
      end

    end

  end

end