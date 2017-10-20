require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/ellipse')
require_relative('../../../../lib/cartesius/models/point')

describe Cartesius::Ellipse do

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
        described_class.by_definition(focus1: Cartesius::Point.origin, focus2: Cartesius::Point.origin, distance: 1)
      }.to raise_error(ArgumentError, 'Focus points must be different!')
    end

    it 'should fail when focus are not aligned to axis' do
      expect {
        described_class.by_definition(focus1: Cartesius::Point.origin, focus2: Cartesius::Point.create(x: 1, y: 1), distance: 2)
      }.to raise_error(ArgumentError, 'Focus must be aligned to axis!')
    end

    it 'should fail when sum of distances is not greater than focal distance' do
      expect {
        described_class.by_definition(focus1: Cartesius::Point.create(x: -1, y: 0), focus2: Cartesius::Point.create(x: 1, y: 0), distance: 2)
      }.to raise_error(ArgumentError, 'Sum of distances must be greater than focal distance!')
    end

    it 'should create a simple ellipse with focus on x axis' do
      # x^2/25 + y^2/9 = 1
      ellipse = described_class.by_definition(focus1: Cartesius::Point.create(x: 4, y: 0), focus2: Cartesius::Point.create(x: -4, y: 0), distance: 10)

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 4, y: 0))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: -4, y: 0))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a simple ellipse with focus on y axis' do
      # x^2/9 + y^2/25 = 1
      ellipse = described_class.by_definition(focus1: Cartesius::Point.create(x: 0, y: 4), focus2: Cartesius::Point.create(x: 0, y: -4), distance: 10)

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 0, y: 4))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: 0, y: -4))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a general ellipse with focus on x axis' do
      # (x - 1)^2/25 + (y - 1)^2/9 = 1
      ellipse = described_class.by_definition(focus1: Cartesius::Point.create(x: 5, y: 1), focus2: Cartesius::Point.create(x: -3, y: 1), distance: 10)

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 5, y: 1))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: -3, y: 1))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a general ellipse with focus on y axis' do
      # (x - 1)^2/9 + (y - 1)^2/25 = 1
      ellipse = described_class.by_definition(focus1: Cartesius::Point.create(x: 1, y: 5), focus2: Cartesius::Point.create(x: 1, y: -3), distance: 10)

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 1, y: 5))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: 1, y: -3))
      expect(ellipse.sum_of_distances).to eq(10)
    end

  end

  describe '.by_canonical' do

    it 'should fail when semi axis length is not positive' do
      expect {
        described_class.by_canonical(center: Cartesius::Point.origin, x_semi_axis: 0, y_semi_axis: 0)
      }.to raise_error(ArgumentError, 'Semi axis length must be positive!')
    end

    it 'should fail when semi axis length is the same' do
      expect {
        described_class.by_canonical(center: Cartesius::Point.origin, x_semi_axis: 1, y_semi_axis: 1)
      }.to raise_error(ArgumentError, 'Semi axis length must be different!')
    end

    it 'should create a simple ellipse with focus on x axis' do
      # x^2/25 + y^2/9 = 1
      ellipse = described_class.by_canonical(center: Cartesius::Point.origin, x_semi_axis: 5, y_semi_axis: 3)

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 4, y: 0))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: -4, y: 0))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a simple ellipse with focus on y axis' do
      # x^2/9 + y^2/25 = 1
      ellipse = described_class.by_canonical(center: Cartesius::Point.origin, x_semi_axis: 3, y_semi_axis: 5)

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 0, y: 4))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: 0, y: -4))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a general ellipse with focus on x axis' do
      # (x - 1)^2/25 + (y - 1)^2/9 = 1
      ellipse = described_class.by_canonical(center: Cartesius::Point.create(x: 1, y: 1), x_semi_axis: 5, y_semi_axis: 3)

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 5, y: 1))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: -3, y: 1))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a simple ellipse with focus on y axis' do
      # (x - 1)^2/9 + (y - 1)^2/25 = 1
      ellipse = described_class.by_canonical(center: Cartesius::Point.create(x: 1, y: 1), x_semi_axis: 3, y_semi_axis: 5)

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 1, y: 5))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: 1, y: -3))
      expect(ellipse.sum_of_distances).to eq(10)
    end

  end

  describe '.by_points' do

    it 'should fail when points are not different' do
      expect {
        described_class.by_points(
            center: Cartesius::Point.origin, point1: Cartesius::Point.origin, point2: Cartesius::Point.create(x: 2, y: 1))
      }.to raise_error(ArgumentError, 'Points must be different!')
    end

    it 'should fail when points are not sufficient for center in origin' do
      expect {
        described_class.by_points(
            center: Cartesius::Point.origin, point1: Cartesius::Point.create(x: -5, y: 0), point2: Cartesius::Point.create(x: 5, y: 0))
      }.to raise_error(ArgumentError, 'No Ellipse for these points!')
    end

    it 'should create a simple ellipse with focus on x axis' do
      # x^2/25 + y^2/9 = 1
      ellipse = described_class.by_points(
          center: Cartesius::Point.origin, point1: Cartesius::Point.create(x: -5, y: 0), point2: Cartesius::Point.create(x: 0, y: -3))

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 4, y: 0))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: -4, y: 0))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a simple ellipse with focus on y axis' do
      # x^2/9 + y^2/25 = 1
      ellipse = described_class.by_points(
          center: Cartesius::Point.origin, point1: Cartesius::Point.create(x: 0, y: 5), point2: Cartesius::Point.create(x: 3, y: 0))

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 0, y: 4))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: 0, y: -4))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should fail when points are not sufficient for center in general point' do
      expect {
        described_class.by_points(
            center: Cartesius::Point.create(x: 1, y: 1), point1: Cartesius::Point.create(x: -4, y: 1), point2: Cartesius::Point.create(x: 6, y: 1))
      }.to raise_error(ArgumentError, 'No Ellipse for these points!')
    end

    it 'should create a general ellipse with focus parallel to the x axis' do
      # (x - 1)^2/25 + (y - 1)^2/9 = 1
      ellipse = described_class.by_points(
          center: Cartesius::Point.create(x: 1, y: 1), point1: Cartesius::Point.create(x: -4, y: 1), point2: Cartesius::Point.create(x: 1, y: -2))

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 5, y: 1))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: -3, y: 1))
      expect(ellipse.sum_of_distances).to eq(10)
    end

    it 'should create a simple ellipse with focus parallel to the y axis' do
      # (x - 1)^2/9 + (y - 1)^2/25 = 1
      ellipse = described_class.by_points(
          center: Cartesius::Point.create(x: 1, y: 1), point1: Cartesius::Point.create(x: 1, y: 6), point2: Cartesius::Point.create(x: 4, y: 1))

      expect(ellipse.focus1).to eq(Cartesius::Point.create(x: 1, y: 5))
      expect(ellipse.focus2).to eq(Cartesius::Point.create(x: 1, y: -3))
      expect(ellipse.sum_of_distances).to eq(10)
    end

  end

  describe 'congruent?' do

    let(:ellipse1) {
      described_class.by_definition(focus1: Cartesius::Point.create(x: 4, y: 0), focus2: Cartesius::Point.create(x: -4, y: 0), distance: 10)
    }

    it 'should be false when not ellipse' do
      expect(ellipse1.congruent?(NilClass)).to be_falsey
    end

    it 'should be false when different eccentricity' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.create(x: 3, y: 0), focus2: Cartesius::Point.create(x: -3, y: 0), distance: 10)

      expect(ellipse1.congruent?(ellipse2)).to be_falsey
    end

    it 'should be true when same eccentricity' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.create(x: 0, y: 4), focus2: Cartesius::Point.create(x: 0, y: -4), distance: 10)

      expect(ellipse1.congruent?(ellipse2)).to be_truthy
    end

  end

  describe '==?' do

    let(:ellipse1) {
      described_class.by_definition(focus1: Cartesius::Point.create(x: 4, y: 0), focus2: Cartesius::Point.create(x: -4, y: 0), distance: 10)
    }

    it 'should be false when not ellipse' do
      expect(ellipse1 == NilClass).to be_falsey
    end

    it 'should be false when different focus' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.create(x: 0, y: 4), focus2: Cartesius::Point.create(x: 0, y: -4), distance: 10)

      expect(ellipse1 == ellipse2).to be_falsey
    end

    it 'should be false when different distance' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.create(x: 4, y: 0), focus2: Cartesius::Point.create(x: -4, y: 0), distance: 20)

      expect(ellipse1 == ellipse2).to be_falsey
    end

    it 'should be true when same focus and distance' do
      ellipse2 = described_class.by_definition(focus1: Cartesius::Point.create(x: 4, y: 0), focus2: Cartesius::Point.create(x: -4, y: 0), distance: 10)

      expect(ellipse1 == ellipse2).to be_truthy
    end

    it 'should be true when equivalent (coefficients * 2)' do
      ellipse1 = described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 1)

      ellipse2 = described_class.new(x2: 4, y2: 2, x: 8, y: -4, k: 2)
      expect(ellipse1 == ellipse2).to be_truthy
    end

    it 'should be true when equivalent (coefficients * -2)' do
      ellipse1 = described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 1)

      ellipse2 = described_class.new(x2: -4, y2: -2, x: -8, y: 4, k: -2)
      expect(ellipse1 == ellipse2).to be_truthy
    end

  end

end