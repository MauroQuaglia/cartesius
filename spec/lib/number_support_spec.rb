require_relative('../../spec/spec_helper')
require_relative('../../lib/number_support')

class IncludingClass
  include NumberSupport
end

describe NumberSupport do
  subject {IncludingClass.new}

  describe '.numberfy' do

    it 'should be integer when denominator is equal to 1' do
      expect(subject.numberfy(3, 1)).to eq(3)
    end

    it 'should be rational when denominator is different from 1' do
      expect(subject.numberfy(3, 2)).to eq(Rational(3, 2))
    end

  end

end