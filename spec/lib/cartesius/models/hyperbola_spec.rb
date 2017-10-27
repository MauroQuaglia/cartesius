require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/point')
require_relative('../../../../lib/cartesius/models/hyperbola')

describe Cartesius::Hyperbola do

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
        # x^2 - y^2 = 0
        expect {described_class.new(x2: 1, y2: -1, x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

      it 'should reject a general equation' do
        # (x + 1)^2 - (y - 1)^2 / 2 = 0 --> 2x^2 - y^2 + 4x - 2y + 1 = 0
        expect {described_class.new(x2: 2, y2: -1, x: 4, y: -2, k: 1)}.to raise_error(ArgumentError)
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

    describe 'hyperbola' do

      it 'should accept a simple equation' do
        # x^2 + y^2 / 2 = 1 --> 2x^2 + y^2 - 2 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 0, y: 0, k: -2)}.to raise_error(ArgumentError)
      end

      it 'should accept a general equation' do
        # (x + 1)^2 + (y - 1)^2 / 2 = 1 --> 2x^2 + y^2 + 4x - 2y + 1 = 0
        expect {described_class.new(x2: 2, y2: 1, x: 4, y: -2, k: 1)}.to raise_error(ArgumentError)
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

      it 'should accept a simple equation' do
        # x^2 - y^2  = 1 --> x^2 - y^ 2 - 1 = 0
        expect {described_class.new(x2: 1, y2: -1, x: 0, y: 0, k: -1)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # (x + 1)^2 - (y - 1)^2 / 2 = -1 --> 2x^2 - y^2 + 4x + 2y + 4 = 0
        expect {described_class.new(x2: 2, y2: -1, x: 4, y: 2, k: 4)}.not_to raise_error
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
        described_class.by_definition(focus1: Cartesius::Point.origin, focus2: Cartesius::Point.new(x: 1, y: 1), distance: 2)
      }.to raise_error(ArgumentError, 'Focus must be aligned to axis!')
    end

    it 'should fail when difference of distances is not less than focal distance' do
      expect {
        described_class.by_definition(focus1: Cartesius::Point.new(x: -1, y: 0), focus2: Cartesius::Point.new(x: 1, y: 0), distance: 2)
      }.to raise_error(ArgumentError, 'Difference of distances must be less than focal distance!')
    end

    it 'should create a simple hyperbola with focus on x axis' do
      # x^2/16 - y^2/9 = 1
      hyperbola = described_class.by_definition(focus1: Cartesius::Point.new(x: 5, y: 0), focus2: Cartesius::Point.new(x: -5, y: 0), distance: 8)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 5, y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -5, y: 0))
      expect(hyperbola.difference_of_distances).to eq(8)
    end

    it 'should create a simple hyperbola with focus on y axis' do
      # x^2/16 - y^2/9 = -1
      hyperbola = described_class.by_definition(focus1: Cartesius::Point.new(x: 0, y: 5), focus2: Cartesius::Point.new(x: 0, y: -5), distance: 8)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: 5))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -5))
      expect(hyperbola.difference_of_distances).to eq(8)
    end

    it 'should create a general hyperbola with focus on x axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = 1
      hyperbola = described_class.by_definition(focus1: Cartesius::Point.new(x: 6, y: 1), focus2: Cartesius::Point.new(x: -4, y: 1), distance: 8)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 6, y: 1))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -4, y: 1))
      expect(hyperbola.difference_of_distances).to eq(8)
    end

    it 'should create a general hyperbola with focus on y axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = -1
      hyperbola = described_class.by_definition(focus1: Cartesius::Point.new(x: 1, y: 6), focus2: Cartesius::Point.new(x: 1, y: -4), distance: 8)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 1, y: 6))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 1, y: -4))
      expect(hyperbola.difference_of_distances).to eq(8)
    end

    it 'should create a simple equilateral hyperbola with focus on x axis' do
      # x^2 - y^2 = 1
      hyperbola = described_class.by_definition(focus1: Cartesius::Point.new(x: Math.sqrt(2), y: 0), focus2: Cartesius::Point.new(x: -Math.sqrt(2), y: 0), distance: 2)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: Math.sqrt(2), y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -Math.sqrt(2), y: 0))
      expect(hyperbola.difference_of_distances).to eq(2)
    end

    it 'should create a simple equilateral hyperbola with focus on y axis' do
      # x^2 - y^2 = -1
      hyperbola = described_class.by_definition(focus1: Cartesius::Point.new(x: 0, y: Math.sqrt(2)), focus2: Cartesius::Point.new(x: 0, y: -Math.sqrt(2)), distance: 2)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: Math.sqrt(2)))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -Math.sqrt(2)))
      expect(hyperbola.difference_of_distances).to eq(2)
    end

  end

  describe '.by_canonical' do

    it 'should fail when transverse axis length is not positive' do
      expect {
        described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 0, not_transverse_axis: 1, position: 1)
      }.to raise_error(ArgumentError, 'Axis length must be positive!')
    end

    it 'should fail when not transverse axis length is not positive' do
      expect {
        described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 1, not_transverse_axis: 0, position: 1)
      }.to raise_error(ArgumentError, 'Axis length must be positive!')
    end

    it 'should create a simple hyperbola with focus on x axis' do
      # x^2/16 - y^2/9 = 1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 4, not_transverse_axis: 3, position: 1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 5, y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -5, y: 0))
      expect(hyperbola.difference_of_distances).to eq(8)
    end

    it 'should create a simple hyperbola with focus on y axis' do
      # x^2/16 - y^2/9 = -1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 3, not_transverse_axis: 4, position: -1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: 5))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -5))
      expect(hyperbola.difference_of_distances).to eq(6)
    end

    it 'should create a general hyperbola with focus on x axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = 1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.new(x: 1, y: 1), transverse_axis: 4, not_transverse_axis: 3, position: 1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 6, y: 1))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -4, y: 1))
      expect(hyperbola.difference_of_distances).to eq(8)
    end

    it 'should create a general hyperbola with focus on y axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = -1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.new(x: 1, y: 1), transverse_axis: 3, not_transverse_axis: 4, position: -1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 1, y: 6))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 1, y: -4))
      expect(hyperbola.difference_of_distances).to eq(6)
    end

    it 'should create a simple equilateral hyperbola with focus on x axis' do
      # x^2 - y^2 = 1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 1, not_transverse_axis: 1, position: 1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: Math.sqrt(2), y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -Math.sqrt(2), y: 0))
      expect(hyperbola.difference_of_distances).to eq(2)
    end

    it 'should create a simple equilateral hyperbola with focus on y axis' do
      # x^2 - y^2 = -1
      hyperbola = described_class.by_canonical(center: Cartesius::Point.origin, transverse_axis: 1, not_transverse_axis: 1, position: -1)

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: Math.sqrt(2)))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -Math.sqrt(2)))
      expect(hyperbola.difference_of_distances).to eq(2)
    end

  end

  describe '.by_points' do

    it 'should fail when points are not different' do
      expect {
        described_class.by_points(
            center: Cartesius::Point.origin, vertex: Cartesius::Point.origin, point: Cartesius::Point.new(x: 2, y: 1))
      }.to raise_error(ArgumentError, 'Points must be different!')
    end

    it 'should fail when points are not sufficient for center in origin' do
      expect {
        described_class.by_points(
            center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: -5, y: 0), point: Cartesius::Point.new(x: 5, y: 0))
      }.to raise_error(ArgumentError, 'No Hyperbola for these points!')
    end

    it 'should fail when vertex and center are not aligned' do
      expect {
        described_class.by_points(
            center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: 1, y: 1), point: Cartesius::Point.new(x: 5, y: 0))
      }.to raise_error(ArgumentError, 'Vertex must be aligned with center!')
    end

    it 'should create a simple hyperbola with focus on x axis' do
      # x^2/16 - y^2/9 = 1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: 4, y: 0), point: Cartesius::Point.new(x: 0, y: 3))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 5, y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -5, y: 0))
      expect(hyperbola.difference_of_distances).to eq(8)
    end

    it 'should create a simple hyperbola with focus on y axis' do
      # x^2/16 - y^2/9 = -1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: 0, y: 3), point: Cartesius::Point.new(x: 4, y: 0))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: 5))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -5))
      expect(hyperbola.difference_of_distances).to eq(6)
    end

    it 'should create a general hyperbola with focus on x axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = 1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.new(x:1, y:1), vertex: Cartesius::Point.new(x: 5, y: 1), point: Cartesius::Point.new(x: 1, y: 4))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 6, y: 1))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -4, y: 1))
      expect(hyperbola.difference_of_distances).to eq(8)
    end

    it 'should create a general hyperbola with focus on y axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = -1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.new(x:1, y:1), vertex: Cartesius::Point.new(x: 1, y: 4), point: Cartesius::Point.new(x: 5, y: 1))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 1, y: 6))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 1, y: -4))
      expect(hyperbola.difference_of_distances).to eq(6)
    end

    it 'should create a simple equilateral hyperbola with focus on x axis' do
      # x^2 - y^2 = 1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: 1, y: 0), point: Cartesius::Point.new(x: 0, y: 1))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: Math.sqrt(2), y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -Math.sqrt(2), y: 0))
      expect(hyperbola.difference_of_distances).to eq(2)
    end

    it 'should create a simple equilateral hyperbola with focus on y axis' do
      # x^2 - y^2 = -1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: 0, y: 1), point: Cartesius::Point.new(x: 1, y: 0))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: Math.sqrt(2)))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -Math.sqrt(2)))
      expect(hyperbola.difference_of_distances).to eq(2)
    end

  end


end