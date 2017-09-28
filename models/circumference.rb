require_relative('../models/conic')

class Circumference < Conic

  # Conic
  # Conic equation type: dx + ey + f = 0
  def initialize(x:, y:, k:)
    super(x2: 1, y2: 1, xy: 0, x: x, y: y, k: k)
    build
  end

  def center
    Point.create(x: Rational(-@x_coeff, 2), y: Rational(-@y_coeff, 2))
  end

  def radius
    Math.sqrt(discriminant)
  end

  private

  def build
    if discriminant < 0
      raise ArgumentError.new('Empty set!')
    end

    if discriminant == 0
      raise ArgumentError.new('Point!')
    end
  end

  def discriminant
    Rational(@x_coeff ** 2, 4) + Rational(@y_coeff ** 2, 4) - @k_coeff
  end

end