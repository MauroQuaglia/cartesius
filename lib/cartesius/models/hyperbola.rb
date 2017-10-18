require_relative('../models/conic')
require_relative('../../../lib/cartesius/modules/determinator')
require_relative('../../../lib/cartesius/modules/normalizator')

module Cartesius

  class Hyperbola < Conic
    include Determinator, Normalizator

    # Conic
    # Conic equation type: ax^2 + by^2 + dx + ey + f = 0
    def initialize(x2:, y2:, x:, y:, k:)
      x2, y2, x, y, k = normalize(x2, y2, x, y, k)
      super(x2: x2, y2: y2, xy: 0, x: x, y: y, k: k)
      validation
    end

    def self.by_definition(focus1:, focus2:, difference_of_distances:)
      if focus1 == focus2
        raise ArgumentError.new('Focus points must be different!')
      end

      unless focus1.aligned_horizontally_with?(focus2) or focus1.aligned_vertically_with?(focus2)
        raise ArgumentError.new('Focus must be aligned to axis!')
      end

      focal_distance = Point.distance(point1: focus1, point2: focus2)
      if difference_of_distances >= focal_distance
        raise ArgumentError.new('Difference of distances must be less than focal distance!')
      end

      center = Point.mid(point1: focus1, point2: focus2)
      c2 = Rational(focal_distance, 2) ** 2
      if focus1.aligned_horizontally_with?(focus2)
        a2 = Rational(difference_of_distances, 2) ** 2
        b2 = c2 - a2
        k = a2* b2
      end
      if focus1.aligned_vertically_with?(focus2)
        b2 = Rational(difference_of_distances, 2) ** 2
        a2 = c2 - b2
        k = -a2* b2
      end

      self.new(x2: b2, y2: a2, x: -2 * b2 * center.x, y: -2 * a2 * center.y, k: b2 * center.x ** 2 + a2 * center.y ** 2 + k)
    end

    private

    def validation

      if signum(@x2_coeff * @y2_coeff) >= 0 or determinator == @k_coeff
        coefficients_error
      end

    end

  end

end