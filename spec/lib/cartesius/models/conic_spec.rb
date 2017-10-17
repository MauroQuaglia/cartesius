require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/conic')

describe Conic do

  describe 'empty set' do

    xit 'should return the equation' do
      # x^2 + y^2 = -1 --> x^2 + y^2 + 1 = 0
      expect(
          described_class.new(x2: 1, y2: 1, xy: 0, x: 0, y: 0, k: 1).to_equation
      ).to eq('1x^2 + 1y^2 + 1 = 0')
    end

  end

end