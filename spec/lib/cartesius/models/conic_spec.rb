require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/conic')

describe Conic do

  describe 'empty set' do

    it 'should return the equation with integer' do
      expect(
          described_class.new(x2: 1, y2: 1, xy: 0, x: 0, y: 0, k: 1).to_equation
      ).to eq('+1x^2 +1y^2 +1 = 0')
    end

    it 'should return the equation with rational' do
      expect(
          described_class.new(x2: Rational(1, 2), y2: Rational(-3, 2), xy: 1, x: 0, y: -1, k: 0).to_equation
      ).to eq('+(1/2)x^2 -(3/2)y^2 +1xy -1y = 0')
    end
  end

end