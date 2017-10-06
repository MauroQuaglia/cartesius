require_relative('../../spec_helper')
require_relative('../../../lib/models/ellipse')

describe Ellipse do

  describe '.new' do

    describe 'empty set' do

      it 'should reject a simple equation' do
        # x^2 + y^2 / 2 = -1
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: 2)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = -1
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 5)}.to raise_error(ArgumentError)
      end

    end

    describe 'point' do

      it 'should reject a simple equation' do
        # x^2 + y^2 / 2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 3)}.to raise_error(ArgumentError)
      end

    end

    describe 'line' do

      it 'should reject a simple equation' do
        # y = 0
        expect {described_class.new(x2: 0, y2: 0, x: 0, y: 1, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # x + y + 1 = 0
        expect {described_class.new(x2: 0, y2: 0, x: 1, y: 1, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'circumference' do

      it 'should reject a simple equation' do
        # x^2 + y^2 = 1
        expect {described_class.new(x2: 1, y2: 1, x: 0, y: 0, k: -1)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 1
        expect {described_class.new(x2: 1, y2: 1, x: 2, y: -2, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'ellipse' do

      it 'should accept a simple equation' do
        # x^2 + y^2 / 2 = 1
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: -2)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = 1
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 1)}.not_to raise_error
      end

    end

    describe 'parabola' do

      it 'should reject a simple equation' do
        # y = x^2
        expect {described_class.new(x2: 1, y2: 0, x: 0, y: -1, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # y = x^2 + x + 1
        expect {described_class.new(x2: 1, y2: 0, x: 1, y: -1, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'hyperbola' do

      it 'should reject a simple equation' do
        # x^2 - y^2 / 2 = 1
        expect {described_class.new(x2: 2, y2: -1, x: 0, y: 0, k: -2)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 - (y - 1)^2 / 2 = 1
        expect {described_class.new(x2: 2, y2: -1, x: 4, y: 2, k: -1)}.to raise_error(ArgumentError)
      end

    end

    describe 'plane' do

      it 'should reject the equation' do
        # 0 = 0
        expect {described_class.new(x2: 0, y2: 0, x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

    end

  end

end