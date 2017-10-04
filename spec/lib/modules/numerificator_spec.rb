require_relative('../../spec_helper')
require_relative('../../../lib/modules/numerificator')

class IncludingClass
  include Numerificator
end

describe Numerificator do
  subject {IncludingClass.new}

  describe '.stringfy' do

    it 'should be 0 when integer' do
      expect(subject.stringfy(0)).to eq('0')
    end

    it 'should be 0 when rational' do
      expect(subject.stringfy(Rational(0, 2))).to eq('0')
    end

    it 'should be 2 when integer' do
      expect(subject.stringfy(2)).to eq('2')
    end

    it 'should be 2 when rational' do
      expect(subject.stringfy(Rational(2, 1))).to eq('2')
    end

    it 'should be rational' do
      expect(subject.stringfy(Rational(2, 3))).to eq('2/3')
    end
  end
end