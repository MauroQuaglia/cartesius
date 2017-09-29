require_relative('../models/conic')

class Circumference < Conic

  # Conic
  # Conic equation type: x^2 + y^2 + dx + ey + f = 0
  def initialize(x:, y:, k:)
    super(x2: 1, y2: 1, xy: 0, x: x, y: y, k: k)
    build
  end

  def self.unitary
    new(x: 0, y: 0, k: -1)
  end

  def center
    Point.create(x: numberfy(-@x_coeff, 2), y: numberfy(-@y_coeff, 2))
  end

  def radius
    Math.sqrt(discriminant)
  end

  # TODO: To test when i can create some circunferences.
  def == (circumference)
    circumference.instance_of?(Circumference) and
        circumference.center == self.center and circumference.radius == self.radius
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
    numberfy(@x_coeff ** 2, 4) + numberfy(@y_coeff ** 2, 4) - @k_coeff
  end

end