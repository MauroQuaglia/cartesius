require('cartesius/numerificator')
require('cartesius/neighbourhoods')

module Cartesius
  class Point
    include Numerificator
    attr_reader :x, :y
    TOLERANCE = Rational(1, 100)

    def initialize(x:, y:)
      @x, @y = x.to_r, y.to_r
    end

    def self.origin
      new(x: 0, y: 0)
    end

    def self.distance(point1, point2)
      Math.sqrt((point1.x - point2.x) ** 2 + (point1.y - point2.y) ** 2)
    end

    def origin?
      self == Point.origin
    end

    def to_coordinates
      "(#{stringfy(x)}; #{stringfy(y)})"
    end

    def to_equation
      equationfy('x^2' => 1, 'y^2' => 1, 'x' => -2 * @x, 'y' => -2 * @y, '1' => @x ** 2 + @y ** 2)
    end

    def congruent?(point)
      point.instance_of?(self.class)
    end

    def horizontal?(point)
      OpenNeighbourhood.new(@y, TOLERANCE).include?(point.y)
    end

    def vertical?(point)
      OpenNeighbourhood.new(@x, TOLERANCE).include?(point.x)
    end

    def == (point)
      point.instance_of?(self.class) &&
          horizontal?(point) && vertical?(point)
    end

    alias_method(:eql?, :==)

    private

    def hash
      @x.hash ^ @y.hash
    end
  end
end