require_relative('../../../spec_helper')
require_relative('../../../../lib/conics/models/ellipse')
require_relative('../../../../lib/conics/models/point')

describe Conics::Ellipse do

  describe '.new' do

    describe 'empty set' do

      it 'should reject a simple equation' do
        # x^2 + y^2 / 2 = -1 --> 2x^2 + y^2 + 2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: 2)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = -1 --> 2x^2 + y^2 + 4x -2y + 5 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 5)}.to raise_error(ArgumentError)
      end

    end

    describe 'point' do

      it 'should reject a simple equation' do
        # x^2 + y^2 / 2 = 0 --> 2x^2 + y^2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = 0 --> 2x^2 + y^2 + 4x -2y + 3 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 3)}.to raise_error(ArgumentError)
      end

    end

    describe 'line' do

      it 'should reject a simple equation' do
        # y = 0
        expect {described_class.new(x2: 0, y2: 0, x: 0, y: 1, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # y = -x - 1 --> x + y + 1 = 0
        expect {described_class.new(x2: 0, y2: 0, x: 1, y: 1, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'circumference' do

      it 'should reject a simple equation' do
        # x^2 + y^2 = 1 --> x^2 + y^2 - 1 = 0
        expect {described_class.new(x2: 1, y2: 1, x: 0, y: 0, k: -1)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 + (y - 1)^2 = 1 --> x^2 + y^2 + 2x - 2y + 1 = 0
        expect {described_class.new(x2: 1, y2: 1, x: 2, y: -2, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'ellipse' do

      it 'should accept a simple equation' do
        # x^2 + y^2 / 2 = 1 --> 2x^2 + y^2 - 2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: -2)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = 1 --> 2x^2 + y^2 + 4x - 2y + 1 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 1)}.not_to raise_error
      end

    end

    describe 'parabola' do

      it 'should reject a simple equation' do
        # y = x^2 --> x^2 - y = 0
        expect {described_class.new(x2: 1, y2: 0, x: 0, y: -1, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # y = x^2 + x + 1 --> x^2 + x - y + 1 = 0
        expect {described_class.new(x2: 1, y2: 0, x: 1, y: -1, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'hyperbola' do

      it 'should reject a simple equation' do
        # x^2 - y^2 / 2 = 1 --> 2x^2 - y^2 - 2 = 0
        expect {described_class.new(x2: 2, y2: -1, x: 0, y: 0, k: -2)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 - (y - 1)^2 / 2 = 1 --> 2x^2 - y^2 + 4x + 2y - 1 = 0
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

  describe '.by_definition' do

    it 'should fail when focus are the same' do
      expect {
        described_class.by_definition(focus1: Conics::Point.origin, focus2: Conics::Point.origin, sum_of_distances: 1)
      }.to raise_error(ArgumentError, 'Focus points must be different!')
    end

    it 'should fail when focus are not aligned to axis' do
      expect {
        described_class.by_definition(focus1: Conics::Point.origin, focus2: Conics::Point.create(x: 1, y: 1), sum_of_distances: 2)
      }.to raise_error(ArgumentError, 'Focus must be aligned to axis!')
    end

    it 'should fail when sum of distances is not greater than focal distance' do
      expect {
        described_class.by_definition(focus1: Conics::Point.create(x: -1, y: 0), focus2: Conics::Point.create(x: 1, y: 0), sum_of_distances: 2)
      }.to raise_error(ArgumentError, 'Sum of distances must be greater than focal distance!')
    end

    it 'should create a simple ellipse with focus on x axis' do
      # x^2/25 + y^2/9 = 1
      ellipse = described_class.by_definition(focus1: Conics::Point.create(x: 4, y: 0), focus2: Conics::Point.create(x: -4, y: 0), sum_of_distances: 10)

      expect(ellipse.focus1).to eq(Conics::Point.create(x: 4, y: 0))
      expect(ellipse.focus2).to eq(Conics::Point.create(x: -4, y: 0))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a simple ellipse with focus on y axis' do
      # x^2/9 + y^2/25 = 1
      ellipse = described_class.by_definition(focus1: Conics::Point.create(x: 0, y: 4), focus2: Conics::Point.create(x: 0, y: -4), sum_of_distances: 10)

      expect(ellipse.focus1).to eq(Conics::Point.create(x: 0, y: 4))
      expect(ellipse.focus2).to eq(Conics::Point.create(x: 0, y: -4))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a general ellipse with focus on x axis' do
      # (x - 1)^2/25 + (y - 1)^2/9 = 1
      ellipse = described_class.by_definition(focus1: Conics::Point.create(x: 5, y: 1), focus2: Conics::Point.create(x: -3, y: 1), sum_of_distances: 10)

      expect(ellipse.focus1).to eq(Conics::Point.create(x: 5, y: 1))
      expect(ellipse.focus2).to eq(Conics::Point.create(x: -3, y: 1))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a general ellipse with focus on y axis' do
      # (x - 1)^2/9 + (y - 1)^2/25 = 1
      ellipse = described_class.by_definition(focus1: Conics::Point.create(x: 1, y: 5), focus2: Conics::Point.create(x: 1, y: -3), sum_of_distances: 10)

      expect(ellipse.focus1).to eq(Conics::Point.create(x: 1, y: 5))
      expect(ellipse.focus2).to eq(Conics::Point.create(x: 1, y: -3))
      expect(ellipse.sum_of_distances).to eq(10)
    end

  end

  describe '.by_canonical' do

    it 'should fail when semi axis length is not positive' do
      expect {
        described_class.by_canonical(center: Conics::Point.origin, x_semi_axis: 0, y_semi_axis: 0)
      }.to raise_error(ArgumentError, 'Semi axis length must be positive!')
    end

    it 'should fail when semi axis length is the same' do
      expect {
        described_class.by_canonical(center: Conics::Point.origin, x_semi_axis: 1, y_semi_axis: 1)
      }.to raise_error(ArgumentError, 'Semi axis length must be different!')
    end

    it 'should create a simple ellipse with focus on x axis' do
      # x^2/25 + y^2/9 = 1
      ellipse = described_class.by_canonical(center: Conics::Point.origin, x_semi_axis: 5, y_semi_axis: 3)

      expect(ellipse.focus1).to eq(Conics::Point.create(x: 4, y: 0))
      expect(ellipse.focus2).to eq(Conics::Point.create(x: -4, y: 0))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a simple ellipse with focus on y axis' do
      # x^2/9 + y^2/25 = 1
      ellipse = described_class.by_canonical(center: Conics::Point.origin, x_semi_axis: 3, y_semi_axis: 5)

      expect(ellipse.focus1).to eq(Conics::Point.create(x: 0, y: 4))
      expect(ellipse.focus2).to eq(Conics::Point.create(x: 0, y: -4))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a general ellipse with focus on x axis' do
      # (x - 1)^2/25 + (y - 1)^2/9 = 1
      ellipse = described_class.by_canonical(center: Conics::Point.create(x: 1, y: 1), x_semi_axis: 5, y_semi_axis: 3)

      expect(ellipse.focus1).to eq(Conics::Point.create(x: 5, y: 1))
      expect(ellipse.focus2).to eq(Conics::Point.create(x: -3, y: 1))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a simple ellipse with focus on y axis' do
      # (x - 1)^2/9 + (y - 1)^2/25 = 1
      ellipse = described_class.by_canonical(center: Conics::Point.create(x: 1, y: 1), x_semi_axis: 3, y_semi_axis: 5)

      expect(ellipse.focus1).to eq(Conics::Point.create(x: 1, y: 5))
      expect(ellipse.focus2).to eq(Conics::Point.create(x: 1, y: -3))
      expect(ellipse.sum_of_distances).to eq(10)
    end

  end

end