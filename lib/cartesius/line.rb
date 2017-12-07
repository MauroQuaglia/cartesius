require('cartesius/numerificator')

module Cartesius

  class Line
    include Numerificator
    VERTICAL_SLOPE = Float::INFINITY
    HORIZONTAL_SLOPE = 0

    def initialize(x:, y:, k:)
      @x_coeff, @y_coeff, @k_coeff = x.to_r, y.to_r, k.to_r
      validation
    end

    def self.create(slope:, known_term:)
      new(x: -slope.to_r, y: 1, k: -known_term.to_r)
    end

    def self.horizontal(known_term:)
      new(x: 0, y: 1, k: -known_term.to_r)
    end

    def self.vertical(known_term:)
      new(x: 1, y: 0, k: -known_term.to_r)
    end

    def self.by_points(point1:, point2:)
      if point1 == point2
        raise ArgumentError.new('Points must be different!')
      end

      if point1.y == point2.y
        return horizontal(known_term: point1.y)
      end

      if point1.x == point2.x
        return vertical(known_term: point1.x)
      end

      slope = Rational(point2.y - point1.y, point2.x - point1.x)
      known_term = point1.y - slope * point1.x

      create(slope: slope, known_term: known_term)
    end

    def self.x_axis
      horizontal(known_term: 0)
    end

    def self.y_axis
      vertical(known_term: 0)
    end

    def self.ascending_bisector
      new(x: -1, y: 1, k: 0)
    end

    def self.descending_bisector
      new(x: 1, y: 1, k: 0)
    end

    def slope
      @y_coeff == 0 ? VERTICAL_SLOPE : Rational(-@x_coeff, @y_coeff)
    end

    def known_term
      @y_coeff == 0 ? Rational(-@k_coeff, @x_coeff) : Rational(-@k_coeff, @y_coeff)
    end

    def x_axis?
      self == Line.x_axis
    end

    def y_axis?
      self == Line.y_axis
    end

    def ascending_bisector?
      self == Line.ascending_bisector
    end

    def descending_bisector?
      self == Line.descending_bisector
    end

    # OK
    def horizontal?
      slope == HORIZONTAL_SLOPE
    end

    # OK
    def vertical?
      slope == VERTICAL_SLOPE
    end

    # OK
    def inclined?
      ascending? or descending?
    end

    # OK
    def ascending?
      slope != VERTICAL_SLOPE and slope > 0
    end

    # OK
    def descending?
      slope < 0
    end

    # OK
    def parallel?(line)
      line.slope == slope
    end

    # OK
    def perpendicular?(line)
      if line.slope == HORIZONTAL_SLOPE
        slope == VERTICAL_SLOPE
      elsif line.slope == VERTICAL_SLOPE
        slope == HORIZONTAL_SLOPE
      else
        line.slope * slope == -1
      end
    end

    def include?(point)
      if vertical?
        return known_term == point.x
      end
      point.y == slope * point.x + known_term
    end

    def x_intercept
      @x_coeff.zero? ? nil : -Rational(@k_coeff, @x_coeff)
    end

    def y_intercept
      @y_coeff.zero? ? nil : -Rational(@k_coeff, @y_coeff)
    end

    def to_equation
      equationfy(
          'x' => @x_coeff, 'y' => @y_coeff, '1' => @k_coeff
      )
    end

    # OK
    def congruent?(line)
      line.instance_of?(self.class)
    end

    # OK
    def == (line)
      line.instance_of?(self.class) and
          line.slope == slope and line.known_term == known_term
    end

    private

    def validation
      if (@x_coeff == 0 and @y_coeff == 0)
        raise ArgumentError.new('Invalid coefficients!')
      end
    end

  end
end