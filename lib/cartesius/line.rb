require('cartesius/numerificator')

module Cartesius

  class Line
    include Numerificator
    VERTICAL_SLOPE = Float::INFINITY
    HORIZONTAL_SLOPE = 0

    private_constant(:VERTICAL_SLOPE)
    private_constant(:HORIZONTAL_SLOPE)

    # equation type: dx + ey + f = 0
    def initialize(x:, y:, k:)
      @x_coeff, @y_coeff, @k_coeff = x.to_r, y.to_r, k.to_r
      validation
    end

    def self.create(slope:, known_term:)
      new(x: -slope.to_r, y: 1, k: -known_term.to_r)
    end

    def self.horizontal(known_term:)
      create(slope: HORIZONTAL_SLOPE, known_term: known_term)
    end

    def self.vertical(known_term:)
      new(x: 1, y: 0, k: -known_term.to_r)
    end

    def self.by_points(point1:, point2:)
      if point1 == point2
        raise ArgumentError.new('Points must be different!')
      end

      if point1.x == point2.x
        return vertical(known_term: point1.x)
      else
        m, q = Cramer.solution2(
            [point1.x, 1],
            [point2.x, 1],
            [point1.y, point2.y]
        )
        create(slope: m, known_term: q)
      end
    end

    def self.x_axis
      horizontal(known_term: 0)
    end

    def self.y_axis
      vertical(known_term: 0)
    end

    def self.ascending_bisector
      create(slope: 1, known_term: 0)
    end

    def self.descending_bisector
      create(slope: -1, known_term: 0)
    end

    #TODO ACC
    def slope
      @y_coeff.zero? ? VERTICAL_SLOPE : Rational(-@x_coeff, @y_coeff)
    end

    #TODO ACC
    def known_term
      @y_coeff.zero? ? Rational(-@k_coeff, @x_coeff) : Rational(-@k_coeff, @y_coeff)
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

    def horizontal?
      slope == HORIZONTAL_SLOPE
    end

    def vertical?
      slope == VERTICAL_SLOPE
    end

    def inclined?
      ascending? or descending?
    end

    def ascending?
      slope != VERTICAL_SLOPE and slope > HORIZONTAL_SLOPE
    end

    def descending?
      slope < HORIZONTAL_SLOPE
    end

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
        point.x == known_term
      else
        point.y == slope * point.x + known_term
      end
    end

    def x_intercept
      unless @x_coeff.zero?
        -Rational(@k_coeff, @x_coeff)
      end
    end

    def y_intercept
      unless @y_coeff.zero?
        -Rational(@k_coeff, @y_coeff)
      end
    end

    def to_equation
      equationfy(
          'x' => @x_coeff, 'y' => @y_coeff, '1' => @k_coeff
      )
    end

    def congruent?(line)
      line.instance_of?(self.class)
    end

    def == (line)
      line.instance_of?(self.class) and
          line.slope == slope and line.known_term == known_term
    end

    private

    def validation
      if @x_coeff.zero? and @y_coeff.zero?
        raise ArgumentError.new('Invalid coefficients!')
      end
    end

  end
end