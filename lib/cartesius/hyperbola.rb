require('cartesius/segment')
require('cartesius/determinator')
require('cartesius/numerificator')
require('cartesius/cramer')

module Cartesius

  class Hyperbola
    include Determinator, Numerificator

    # Conic
    # Conic equation type: ax^2 + by^2 + dx + ey + f = 0
    def initialize(x2:, y2:, x:, y:, k:)
      x2, y2, x, y, k = normalize(x2, y2, x, y, k)
      @x2_coeff, @y2_coeff, @x_coeff, @y_coeff, @k_coeff = x2.to_r, y2.to_r, x.to_r, y.to_r, k.to_r
      validation
    end

    def self.by_definition(focus1:, focus2:, distance:)
      if focus1 == focus2
        raise ArgumentError.new('Focus points must be different!')
      end

      focal_axis = Cartesius::Segment.new(extreme1: focus1, extreme2: focus2)
      if focal_axis.inclined?
        raise ArgumentError.new('Focal axis must not be inclined!')
      end

      if distance >= focal_axis.length
        raise ArgumentError.new('Difference between distances must be less than focal distance!')
      end

      c2 = Rational(focal_axis.length, 2)**2
      if focal_axis.horizontal?
        a2 = Rational(distance, 2)**2
        b2 = c2 - a2
        position = 1
      else
        b2 = Rational(distance, 2)**2
        a2 = c2 - b2
        position = -1
      end

      center = focal_axis.mid

      self.new(
          x2: b2,
          y2: -a2,
          x: -2 * b2 * center.x,
          y: 2 * a2 * center.y,
          k: b2 * center.x**2 - a2 * center.y**2 + -position * a2 * b2
      )
    end

    def self.by_canonical(transverse_axis:, not_transverse_axis:)
      if transverse_axis.inclined? or not_transverse_axis.inclined?
        raise ArgumentError.new('Axes must not be inclined!')
      end

      if transverse_axis.mid != not_transverse_axis.mid
        raise ArgumentError.new('Axes must be the same mid point!')
      end

      if transverse_axis.horizontal?
        a2 = Rational(transverse_axis.length, 2)**2
        b2 = Rational(not_transverse_axis.length, 2)**2
        position = 1
      else
        a2 = Rational(not_transverse_axis.length, 2)**2
        b2 = Rational(transverse_axis.length, 2)**2
        position = -1
      end

      center = transverse_axis.mid

      self.new(x2: b2, y2: -a2, x: -2 * b2 * center.x, y: 2 * a2 * center.y, k: b2 * center.x ** 2 - a2 * center.y ** 2 + -position * a2 * b2)
    end

    def self.by_points(center:, vertex:, point:)
      if center == vertex or center == point or vertex == point
        raise ArgumentError.new('Points must be different!')
      end

      unless vertex.aligned_horizontally_with?(center) or vertex.aligned_vertically_with?(center)
        raise ArgumentError.new('Vertex must be aligned with center!')
      end

      semi_axis = Segment.new(extreme1: center, extreme2: vertex)
      if semi_axis.horizontal?
        position = 1
      else
        position = -1
      end

      shifted1 = Point.new(x: vertex.x - center.x, y: vertex.y - center.y)
      shifted2 = Point.new(x: point.x - center.x, y: point.y - center.y)

      begin
        alfa, beta = Cramer.solution2(
            [shifted1.x ** 2, shifted1.y ** 2],
            [shifted2.x ** 2, shifted2.y ** 2],
            [1, 1]
        )
      rescue
        raise ArgumentError.new('No Hyperbola for these points!')
      end

      a2 = Rational(1, alfa)
      b2 = Rational(1, beta)

      self.new(x2: b2, y2: -a2, x: -2 * b2 * center.x, y: 2 * a2 * center.y, k: b2 * center.x ** 2 - a2 * center.y ** 2 + -position * a2 * b2)
    end

    def focus1
      if position == 1
        return Point.new(x: center.x + Math.sqrt(a2 + b2), y: center.y)
      end
      if position == -1
        return Point.new(x: center.x, y: center.y + Math.sqrt(a2 + b2))
      end
    end

    def focus2
      if position == 1
        return Point.new(x: center.x - Math.sqrt(a2 + b2), y: center.y)
      end
      if position == -1
        return Point.new(x: center.x, y: center.y - Math.sqrt(a2 + b2))
      end
    end

    def focal_distance
      Point.distance(focus1, focus2)
    end

    def center
      Point.new(x: centrum[:xc], y: centrum[:yc])
    end

    def distance
      if position == 1
        return 2 * Math.sqrt(a2)
      end
      if position == -1
        return 2 * Math.sqrt(b2)
      end
    end

    def congruent?(hyperbola)
      hyperbola.instance_of?(Hyperbola) and
          hyperbola.eccentricity == self.eccentricity
    end

    def == (hyperbola)
      hyperbola.instance_of?(Hyperbola) and
          hyperbola.focus1 == self.focus1 and hyperbola.focus2 == self.focus2 and hyperbola.distance == self.distance
    end

    private

    def validation

      if signum(@x2_coeff * @y2_coeff) >= 0 or determinator == @k_coeff
        raise ArgumentError.new('Invalid coefficients!')
      end

    end

    def position
      signum(determinator - @k_coeff)
    end

  end

end