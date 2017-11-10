require('cartesius/numerificator')

module Cartesius

  class Point
    include Numerificator
    attr_reader :x, :y

    def initialize(x:, y:)
      @x, @y = x.to_r, y.to_r
    end

    def self.origin
      new(x: 0, y: 0)
    end

    def self.distance(point1, point2)
      Math.sqrt(
          (point1.x - point2.x) ** 2 + (point1.y - point2.y) ** 2
      )
    end

    def origin?
      self == Point.origin
    end

    def aligned_horizontally_with?(point)
      @y == point.y
    end

    def aligned_vertically_with?(point)
      @x == point.x
    end

    def distance_from(point)
      Math.sqrt(
          (@x - point.x) ** 2 + (@y - point.y) ** 2
      )
    end

    def to_coordinates
      "(#{stringfy(x)}; #{stringfy(y)})"
    end

    def to_equation
      equationfy(
          'x^2' => 1, 'y^2' => 1, 'x' => -2 * @x, 'y' => -2 * @y, '1' => @x ** 2 + @y ** 2
      )
    end

    def congruent?(point)
      point.instance_of?(Point)
    end

    def == (point)
      congruent?(point) and
          point.x == @x and point.y == @y
    end

  end

end