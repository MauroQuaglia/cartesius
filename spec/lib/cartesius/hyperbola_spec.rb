require_relative('../../spec_helper')
require('cartesius/hyperbola')
require('cartesius/point')

describe Cartesius::Hyperbola do

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
      expect(hyperbola.distance).to eq(8)
    end

    it 'should create a simple hyperbola with focus on y axis' do
      # x^2/16 - y^2/9 = -1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: 0, y: 3), point: Cartesius::Point.new(x: 4, y: 0))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: 5))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -5))
      expect(hyperbola.distance).to eq(6)
    end

    it 'should create a general hyperbola with focus on x axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = 1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.new(x:1, y:1), vertex: Cartesius::Point.new(x: 5, y: 1), point: Cartesius::Point.new(x: 1, y: 4))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 6, y: 1))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -4, y: 1))
      expect(hyperbola.distance).to eq(8)
    end

    it 'should create a general hyperbola with focus on y axis' do
      # (x - 1)^2/16 - (y - 1)^2/9 = -1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.new(x:1, y:1), vertex: Cartesius::Point.new(x: 1, y: 4), point: Cartesius::Point.new(x: 5, y: 1))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 1, y: 6))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 1, y: -4))
      expect(hyperbola.distance).to eq(6)
    end

    it 'should create a simple equilateral hyperbola with focus on x axis' do
      # x^2 - y^2 = 1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: 1, y: 0), point: Cartesius::Point.new(x: 0, y: 1))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: Math.sqrt(2), y: 0))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: -Math.sqrt(2), y: 0))
      expect(hyperbola.distance).to eq(2)
    end

    it 'should create a simple equilateral hyperbola with focus on y axis' do
      # x^2 - y^2 = -1
      hyperbola =
          described_class.by_points(center: Cartesius::Point.origin, vertex: Cartesius::Point.new(x: 0, y: 1), point: Cartesius::Point.new(x: 1, y: 0))

      expect(hyperbola.focus1).to eq(Cartesius::Point.new(x: 0, y: Math.sqrt(2)))
      expect(hyperbola.focus2).to eq(Cartesius::Point.new(x: 0, y: -Math.sqrt(2)))
      expect(hyperbola.distance).to eq(2)
    end

  end


end