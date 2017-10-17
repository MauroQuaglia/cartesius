require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/modules/numerificator')

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
end