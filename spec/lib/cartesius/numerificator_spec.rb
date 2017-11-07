require_relative('../../spec_helper')
require('cartesius/numerificator')

class IncludingClass
  include Numerificator
end

describe Numerificator do
  subject {IncludingClass.new}

  describe '#stringfy' do

    it 'should be 0 when integer' do
      expect(subject.send(:stringfy, 0)).to eq('0')
    end

    it 'should be 0 when rational' do
      expect(subject.send(:stringfy, Rational(0, 2))).to eq('0')
    end

    it 'should be 2 when integer' do
      expect(subject.send(:stringfy, 2)).to eq('2')
    end

    it 'should be 2 when rational' do
      expect(subject.send(:stringfy, Rational(2, 1))).to eq('2')
    end

    it 'should be rational' do
      expect(subject.send(:stringfy, Rational(2, 3))).to eq('2/3')
    end
  end

  describe '#signum' do

    it 'should be -1 for negative number' do
      expect(subject.send(:signum, -2)).to eq(-1)
    end

    it 'should be 1 for zero' do
      expect(subject.send(:signum, 0)).to eq(+1)
    end

    it 'should be +1 for positive number' do
      expect(subject.send(:signum, +2)).to eq(+1)
    end

  end

  describe '#monomial' do

    it 'should be integer with positive sign' do
      expect(subject.send(:monomial, 2, 'x')).to eq('+2x')
    end

    it 'should be integer with negative sign' do
      expect(subject.send(:monomial, -2, 'x')).to eq('-2x')
    end

    it 'should be rational with positive sign' do
      expect(subject.send(:monomial, Rational(3, 2), 'x')).to eq('+(3/2)x')
    end

    it 'should be rational with negative sign' do
      expect(subject.send(:monomial, -Rational(3, 2), 'x')).to eq('-(3/2)x')
    end

  end

  describe '#signum_symbol' do

    it 'should be + for positive number' do
      expect(subject.send(:signum_symbol, 1)).to eq('+')
    end

    it 'should be + for zero' do
      expect(subject.send(:signum_symbol, 0)).to eq('+')
    end

    it 'should be - for negative number' do
      expect(subject.send(:signum_symbol, -1)).to eq('-')
    end

  end

  describe '#equationfy' do

    it 'should return the equation with integer' do
      expect(subject.send(:equationfy,
                          {'x^2' => 1, 'y^2' => 1, 'xy' => 0, 'x' => 0, 'y' => 0, '1' => 2}
      )).to eq('+1x^2 +1y^2 +2 = 0')
    end

    it 'should return the equation with rational' do
      expect(subject.send(:equationfy,
                          {'x^2' => Rational(1, 2), 'y^2' => Rational(-3, 2), 'xy' => 1, 'x' => 0, 'y' => -1, '1' => 0}
      )).to eq('+(1/2)x^2 -(3/2)y^2 +1xy -1y = 0')
    end
  end

  describe '#normalize' do

    it 'should normalize coefficients by first negative coefficient' do
      expect(
          subject.send(:normalize, -1, -1, 0, 1)
      ).to eq([1, 1, 0, -1])
    end

    it 'should normalize coefficients by first zero coefficient' do
      expect(
          subject.send(:normalize, 0, -1, 0, 1)
      ).to eq([0, -1, 0, 1])
    end

    it 'should normalize coefficients by first positive coefficient' do
      expect(
          subject.send(:normalize, 1, -1, 0, 1)
      ).to eq([1, -1, 0, 1])
    end

  end



end