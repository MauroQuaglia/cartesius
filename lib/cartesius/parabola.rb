require('cartesius/point')
require('cartesius/line')
require('cartesius/numerificator')
require('cartesius/cramer')

module Cartesius

  class Parabola
    include Numerificator

    # Conic
    # Conic equation type: ax^2 + dx - y + f = 0
    def initialize(x2:, x:, k:)
      @x2_coeff, @x_coeff, @y_coeff, @k_coeff = x2.to_r, x.to_r, -1, k.to_r
      validation
    end

    def self.by_definition(directrix:, focus:)
      if directrix.include?(focus)
        raise ArgumentError.new('Focus belongs to directrix!')
      end

      unless directrix.horizontal?
        raise ArgumentError.new('Directrix is not parallel to x-axis!')
      end

      a = Rational(1, 2 * (focus.y - directrix.y_intercept))
      b = -2 * a * focus.x
      c = a * (focus.x ** 2) + focus.y - Rational(1, 4 * a)

      self.new(x2: a, x: b, k: c)
    end

    def self.by_points(point1:, point2:, point3:)
      if point1 == point2 or point1 == point3 or point2 == point3
        raise ArgumentError.new('Points must be different!')
      end

      begin
        a, b, c = Cramer.solution3(
            [point1.x ** 2, point1.x, 1],
            [point2.x ** 2, point2.x, 1],
            [point3.x ** 2, point3.x, 1],
            [point1.y, point2.y, point3.y]
        )
      rescue
        raise ArgumentError.new('Points are not valid!')
      end

      self.new(x2: -a, x: -b, k: -c)
    end

    def directrix
      Line.horizontal(known_term: Rational(-delta - 1, 4 * @x2_coeff))
    end

    def focus
      Point.new(x: Rational(-@x_coeff, 2 * @x2_coeff), y: Rational(1 - delta, 4 * @x2_coeff))
    end

    def vertex
      Point.new(x: Rational(-@x_coeff, 2 * @x2_coeff), y: Rational(-delta, 4 * @x2_coeff))
    end

    def symmetry_axis
      Line.vertical(known_term: Rational(-@x_coeff, 2* @x2_coeff))
    end

    def unitary_convex?
      self == Parabola.unitary_convex
    end

    def unitary_concave?
      self == Parabola.unitary_concave
    end

    def == (parabola)
      parabola.instance_of?(Parabola) and
          parabola.focus == self.focus and parabola.directrix == self.directrix
    end

    def to_equation
      equationfy(
          'x^2' => @x2_coeff, 'x' => @x_coeff, 'y' => @y_coeff, '1' => @k_coeff
      )
    end

    private

    def validation
      if @x2_coeff == 0
        raise ArgumentError.new('Invalid coefficients!')
      end
    end

    def delta
      (@x_coeff ** 2) - (4 * @x2_coeff * @k_coeff)
    end

  end
end