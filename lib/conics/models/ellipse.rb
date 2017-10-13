require_relative('../models/conic')
require_relative('../../../lib/conics/modules/determinator')
require_relative('../../../lib/conics/modules/normalizator')
require_relative('../../../lib/conics/support/cramer')

module Conics

  class Ellipse < Conic
    include Determinator, Normalizator

    # Conic
    # Conic equation type: ax^2 + by^2 + dx + ey + f = 0
    def initialize(x2:, y2:, x:, y:, k:)
      normalize(x2, y2, x, y, k)
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
      c2 = Rational(focal_distance, 2) ** 2
      if focus1.aligned_horizontally_with?(focus2)
        a2 = Rational(sum_of_distances, 2) ** 2
        b2 = a2 - c2
      end
      if focus1.aligned_vertically_with?(focus2)
        b2 = Rational(sum_of_distances, 2) ** 2
        a2 = b2 - c2
      end

      self.new(x2: b2, y2: a2, x: -2 * b2 * center.x, y: -2 * a2 * center.y, k: b2 * center.x ** 2 + a2 * center.y ** 2 - a2 * b2)
    end

    def self.by_canonical(center:, x_semi_axis:, y_semi_axis:)
      if x_semi_axis <= 0 or y_semi_axis <= 0
        raise ArgumentError.new('Semi axis length must be positive!')
      end

      if x_semi_axis == y_semi_axis
        raise ArgumentError.new('Semi axis length must be different!')
      end

      b2 = y_semi_axis ** 2
      a2 = x_semi_axis ** 2

      self.new(x2: b2, y2: a2, x: -2 * b2 * center.x, y: -2 * a2 * center.y, k: b2 * center.x ** 2 + a2 * center.y ** 2 - a2 * b2)
    end

    def self.by_points(center:, point1:, point2:)
      if center == point1 or center == point2 or point1 == point2
        raise ArgumentError.new('Points must be different!')
      end

      shifted1 = Point.create(x: point1.x - center.x, y: point1.y - center.y)
      shifted2 = Point.create(x: point2.x - center.x, y: point2.y - center.y)

      begin
        alfa, beta = Cramer.solution2(
            [shifted1.x ** 2, shifted1.y ** 2],
            [shifted2.x ** 2, shifted2.y ** 2],
            [1, 1]
        )
      rescue
        raise ArgumentError.new('No Ellipse for these points!')
      end

      a2 = Rational(1, alfa)
      b2 = Rational(1, beta)

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

    #TODO test
    def x_semi_axis_length
      Math.sqrt(a2)
    end

    #TODO test
    def y_semi_axis_length
      Math.sqrt(b2)
    end

    #TODO test
    def major_semi_axis
      [x_semi_axis_length, y_semi_axis_length].max
    end

    #TODO test
    def minor_semi_axis
      [x_semi_axis_length, y_semi_axis_length].min
    end

    #TODO test
    def vertices
      [
          Point.create(x: centrum[:xc] + x_semi_axis_length, y: centrum[:yc]),
          Point.create(x: centrum[:xc], y: centrum[:yc] - y_semi_axis_length),
          Point.create(x: centrum[:xc] - x_semi_axis_length, y: centrum[:yc]),
          Point.create(x: centrum[:xc], y: centrum[:yc] + y_semi_axis_length)
      ]
    end

    #TODO test
    def eccentricity
    end

    #TODO test
    def congruent?(ellipse)
    end

    #TODO test
    def == (ellipse)
    end

    private

    def validation
      if @x2_coeff <= 0 or @y2_coeff <= 0 or @x2_coeff == @y2_coeff or determinator <= @k_coeff
        coefficients_error
      end
    end

  end

end