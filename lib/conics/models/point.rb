require_relative('../models/conic')
require_relative('../../../lib/conics/modules/determinator')

module Conics

  class Point < Conic
    include Determinator
    attr_reader :y

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

    def origin?
      self == Point.origin
    end

    def aligned_horizontally_with?(point)
      self.y == point.y
    end

    def aligned_vertically_with?(point)
      self.x == point.x
    end

    def self.distance(point1:, point2:)
      Math.sqrt((point1.x - point2.x) ** 2 + (point1.y - point2.y) ** 2)
    end

    def self.mid(point1:, point2:)
      create(x: Rational(point1.x + point2.x, 2), y: Rational(point1.y + point2.y, 2))
    end

    def to_coordinates
      "(#{stringfy(x)}; #{stringfy(y)})"
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

      # To avoid the override of a Kernel method.
      @y = centrum[:yc]
    end

  end

end