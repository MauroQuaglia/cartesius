require_relative('../models/conic')
require_relative('../models/modules/determinator')

class Point < Conic
  include Determinator

  # Degenerate conic
  # Conic equation type: x^2 + y^2 + dx + ey + f = 0
  def initialize(x:, y:, k:)
    super(x2: 1, y2: 1, xy: 0, x: x, y: y, k: k)
    validation
  end

  def self.create(x:, y:)
    x, y = x.to_r, y.to_r
    new(x: -2 * x, y: -2 * y, k: (x ** 2) + (y ** 2))
  end

  def self.origin
    new(x: 0, y: 0, k: 0)
  end

  def x
    centrum[:xc]
  end

  def y
    centrum[:yc]
  end

  def origin?
    self == Point.origin
  end

  def to_coordinates
    "(#{x}; #{y})"
  end

  def == (point)
    point.instance_of?(Point) and
        point.x == self.x and point.y == self.y
  end

  private

  def validation
    if determinator != @k_coeff
      coefficients_error
    end
  end

end