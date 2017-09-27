require_relative('../models/conic')

class Point < Conic
  attr_reader :x, :y

  # Degenerate conic
  # Conic equation type: x^2 + y^2 + dx + ey + f = 0
  def initialize(x:, y:, k:)
    super(x2: 1, y2: 1, xy: 0, x: x, y: y, k: k)
    build
  end

  private

  def build
    discriminant = Rational(@x_coeff ** 2, 4) + Rational(@y_coeff ** 2, 4) - @k_coeff

    if discriminant < 0
      raise ArgumentError.new('Empty set!')
    end

    if discriminant > 0
      raise ArgumentError.new('Circumference!')
    end

    @x = Rational(-@x_coeff, 2)
    @y = Rational(-@y_coeff, 2)
  end

end