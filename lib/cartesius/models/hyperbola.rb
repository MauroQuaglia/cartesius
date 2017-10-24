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

    def self.by_definition(focus1:, focus2:, distance:)
      if focus1 == focus2
        raise ArgumentError.new('Focus points must be different!')
      end

      unless focus1.aligned_horizontally_with?(focus2) or focus1.aligned_vertically_with?(focus2)
        raise ArgumentError.new('Focus must be aligned to axis!')
      end

      focal_distance = Point.distance(point1: focus1, point2: focus2)
      if distance >= focal_distance
        raise ArgumentError.new('Difference of distances must be less than focal distance!')
      end

      center = Point.mid(point1: focus1, point2: focus2)
      c2 = Rational(focal_distance, 2) ** 2
      if focus1.aligned_horizontally_with?(focus2)
        a2 = Rational(distance, 2) ** 2
        b2 = c2 - a2
        position = 1
      end
      if focus1.aligned_vertically_with?(focus2)
        b2 = Rational(distance, 2) ** 2
        a2 = c2 - b2
        position = -1
      end

      self.new(x2: b2, y2: -a2, x: -2 * b2 * center.x, y: 2 * a2 * center.y, k: b2 * center.x ** 2 - a2 * center.y ** 2 + -position * a2 * b2)
    end

    def self.by_canonical(center:, transverse_axis:, not_transverse_axis:, position:)
      if transverse_axis <= 0 or not_transverse_axis <= 0
        raise ArgumentError.new('Axis length must be positive!')
      end

      unless [-1, 1].include?(position)
        raise ArgumentError.new('Position must be up or right!')
      end

      if position == -1
        a2 = not_transverse_axis ** 2
        b2 = transverse_axis ** 2
      end

      if position == 1
        a2 = transverse_axis ** 2
        b2 = not_transverse_axis ** 2
      end

      self.new(x2: b2, y2: -a2, x: -2 * b2 * center.x, y: 2 * a2 * center.y, k: b2 * center.x ** 2 - a2 * center.y ** 2 + -position * a2 * b2)
    end

    def focus1
      if position == 1
        return Point.create(x: center.x + Math.sqrt(a2 + b2), y: center.y)
      end
      if position == -1
        return Point.create(x: center.x, y: center.y + Math.sqrt(a2 + b2))
      end
    end

    def focus2
      if position == 1
        return Point.create(x: center.x - Math.sqrt(a2 + b2), y: center.y)
      end
      if position == -1
        return Point.create(x: center.x, y: center.y - Math.sqrt(a2 + b2))
      end
    end

    def focal_distance
      Point.distance(point1: focus1, point2: focus2)
    end

    def center
      Point.create(x: centrum[:xc], y: centrum[:yc])
    end

    def difference_of_distances
      if position == 1
        return 2 * Math.sqrt(a2)
      end
      if position == -1
        return 2 * Math.sqrt(b2)
      end
    end

    def equilateral?
    end

    private

    def validation

      if signum(@x2_coeff * @y2_coeff) >= 0 or determinator == @k_coeff
        coefficients_error
      end

    end

    def position
      signum(determinator - @k_coeff)
    end

  end

end