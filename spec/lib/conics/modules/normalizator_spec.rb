require_relative('../../../spec_helper')
require_relative('../../../../lib/conics/modules/normalizator')
require_relative('../../../../lib/conics/modules/numerificator')

class IncludingClass
  include Normalizator, Numerificator
end

describe Normalizator do
  subject {IncludingClass.new}

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