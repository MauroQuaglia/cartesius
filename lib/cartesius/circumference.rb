require('cartesius/line')
require('cartesius/determinator')
require('cartesius/numerificator')
require('cartesius/cramer')

module Cartesius

  class Circumference
    include Determinator, Numerificator

    # Conic
    # Conic equation type: x^2 + y^2 + dx + ey + f = 0
    def initialize(x:, y:, k:)
      @x2_coeff, @y2_coeff, @x_coeff, @y_coeff, @k_coeff = 1, 1, x.to_r, y.to_r, k.to_r
      validation
    end

    def self.by_definition(focus:, radius:)
      alfa = -2 * focus.x
      beta = -2 * focus.y
      gamma = focus.x ** 2 + focus.y ** 2 - radius.to_r ** 2

      self.new(x: alfa, y: beta, k: gamma)
    end

    def self.by_canonical(focus:, radius:)
      by_definition(focus: focus, radius: radius)
    end

    def self.by_points(point1:, point2:, point3:)
      if point1 == point2 or point1 == point3 or point2 == point3
        raise ArgumentError.new('Points must be distinct!')
      end

      line = Line.by_points(point1: point1, point2: point2)
      if line.include?(point3)
        raise ArgumentError.new('Points must not be aligned!')
      end

      alfa, beta, gamma = Cramer.solution3(
          [point1.x, point1.y, 1],
          [point2.x, point2.y, 1],
          [point3.x, point3.y, 1],
          [-(point1.x ** 2 + point1.y ** 2), -(point2.x ** 2 + point2.y ** 2), -(point3.x ** 2 + point3.y ** 2)]
      )

      self.new(x: alfa, y: beta, k: gamma)
    end


    def self.unitary
      new(x: 0, y: 0, k: -1)
    end

    def radius
      Math.sqrt(a2)
    end

    def unitary?
      self == Circumference.unitary
    end

    def == (circumference)
      circumference.instance_of?(Circumference) and
          circumference.center == self.center and circumference.radius == self.radius
    end

    def congruent?(circumference)
      unless circumference.instance_of?(self.class)
        return false
      end

      circumference.radius == self.radius
    end

    def to_equation
      equationfy(
          'x^2' => @x2_coeff, 'y^2' => @y2_coeff, 'x' => @x_coeff, 'y' => @y_coeff, '1' => @k_coeff
      )
    end

    private

    def validation
      if determinator <= @k_coeff
        raise ArgumentError.new('Invalid coefficients!')
      end
    end

  end
end