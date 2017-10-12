require_relative('../models/conic')
require_relative('../../../lib/conics/modules/determinator')

module Conics

  class Ellipse < Conic
    include Determinator

    # Conic
    # Conic equation type: ax^2 + by^2 + dx + ey + f = 0
    def initialize(x2:, y2:, x:, y:, k:)
      super(x2: x2, y2: y2, xy: 0, x: x, y: y, k: k)
      validation
    end

    def self.by_definition(focus1:, focus2:, sum_of_distances:)
      if focus1 == focus2
        raise ArgumentError.new('Focus points must be different!')
      end

      unless focus1.aligned_horizontally_with?(focus2) or focus1.aligned_vertically_with?(focus2)
        raise ArgumentError.new('Focus must be aligned to axis!')
      end

      focal_distance = Point.distance(point1: focus1, point2: focus2)
      if sum_of_distances <= focal_distance
        raise ArgumentError.new('Sum of distances must be greater than focal distance!')
      end

      center = Point.mid(point1: focus1, point2: focus2)
      c2 = power2(Rational(focal_distance, 2))
      if focus1.aligned_horizontally_with?(focus2)
        a2 = power2(Rational(sum_of_distances, 2))
        b2 = a2 - c2
      end
      if focus1.aligned_vertically_with?(focus2)
        b2 = power2(Rational(sum_of_distances, 2))
        a2 = b2 - c2
      end

      self.new(x2: b2, y2: a2, x: -2 * b2 * center.x, y: -2 * a2 * center.y, k: b2 * center.x ** 2 + a2 * center.y ** 2 - a2 * b2)
    end

    def focus1
      if a2 > b2
        Point.create(x: centrum[:xc] + Math.sqrt(a2 - b2), y: centrum[:yc])
      else
        Point.create(x: centrum[:xc], y: centrum[:yc] + Math.sqrt(b2 - a2))
      end
    end

    def focus2
      if a2 > b2
        Point.create(x: centrum[:xc] - Math.sqrt(a2 - b2), y: centrum[:yc])
      else
        Point.create(x: centrum[:xc], y: centrum[:yc] - Math.sqrt(b2 - a2))
      end
    end

    def sum_of_distances
      if a2 > b2
        2 * Math.sqrt(a2)
      else
        2 * Math.sqrt(b2)
      end
    end

    private

    def validation
      if @x2_coeff <= 0 or @y2_coeff <= 0 or @x2_coeff == @y2_coeff or determinator <= @k_coeff
        coefficients_error
      end
    end

  end

end