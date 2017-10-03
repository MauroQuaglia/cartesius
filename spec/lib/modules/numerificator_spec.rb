require_relative('../../spec_helper')
require_relative('../../../lib/modules/numerificator')

class IncludingClass
  include Numerificator
end

describe Numerificator do
  subject {IncludingClass.new}

  describe '.numberfy' do

    it 'should be integer when denominator is equal to 1' do
      expect(subject.numberfy(3, 1)).to eq(3)
    end

    it 'should be rational when denominator is different from 1' do
      expect(subject.numberfy(3, 2)).to eq(Rational(3, 2))
    end

    it 'should be integer when denominator is rational like 1' do
      expect(subject.numberfy(3, Rational(1, 1))).to eq(3)
    end

    it 'should be 0 when numerator is equal to 0' do
      expect(subject.numberfy(0, 2)).to eq(0)
    end

  end

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