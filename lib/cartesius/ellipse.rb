require('cartesius/segment')
require('cartesius/determinator')
require('cartesius/numerificator')
require('cartesius/cramer')

module Cartesius

  class Ellipse
    include Determinator, Numerificator

    # Conic
    # Conic equation type: ax^2 + by^2 + dx + ey + f = 0
    def initialize(x2:, y2:, x:, y:, k:)
      @x2_coeff, @y2_coeff, @x_coeff, @y_coeff, @k_coeff = normalize(x2, y2, x, y, k)
      validation
    end

    def self.by_definition(focus1:, focus2:, distance:)
      if focus1 == focus2
        raise ArgumentError.new('Focus points must be different!')
      end

      focal_axis = Segment.new(extreme1: focus1, extreme2: focus2)
      if focal_axis.inclined?
        raise ArgumentError.new('Focal axis must not be inclined!')
      end

      if distance <= focal_axis.length
        raise ArgumentError.new('Sum of distances must be greater than focal distance!')
      end

      c2 = Rational(focal_axis.length, 2)**2
      if focal_axis.horizontal?
        a2 = Rational(distance, 2)**2
        b2 = a2 - c2
      else
        b2 = Rational(distance, 2)**2
        a2 = b2 - c2
      end

      center = focal_axis.mid

      self.build_by(a2, b2, center)
    end

    def self.by_axes(major_axis:, minor_axis:)
      if major_axis == minor_axis
        raise ArgumentError.new('Axes must be different!')
      end

      if major_axis.inclined? or minor_axis.inclined?
        raise ArgumentError.new('Axes must not be inclined!')
      end

      if major_axis.horizontal? and minor_axis.horizontal?
        raise ArgumentError.new('Axes can not be both horizontal!')
      end

      if major_axis.vertical? and minor_axis.vertical?
        raise ArgumentError.new('Axes can not be both vertical!')
      end

      if major_axis.mid != minor_axis.mid
        raise ArgumentError.new('Axes must be the same mid point!')
      end

      if major_axis.horizontal?
        a2 = Rational(major_axis.length, 2)**2
        b2 = Rational(minor_axis.length, 2)**2
      else
        a2 = Rational(minor_axis.length, 2)**2
        b2 = Rational(major_axis.length, 2)**2
      end

      center = major_axis.mid

      self.build_by(a2, b2, center)
    end

    def self.by_points(center:, point1:, point2:)
      if center == point1 or center == point2 or point1 == point2
        raise ArgumentError.new('Points must be different!')
      end

      shifted1 = Point.new(x: point1.x - center.x, y: point1.y - center.y)
      shifted2 = Point.new(x: point2.x - center.x, y: point2.y - center.y)

      begin
        alfa, beta = Cramer.solution2(
            [shifted1.x**2, shifted1.y**2],
            [shifted2.x**2, shifted2.y**2],
            [1, 1]
        )
      rescue
        raise ArgumentError.new('Center and points are not valid!')
      end

      a2 = Rational(1, alfa)
      b2 = Rational(1, beta)

      self.build_by(a2, b2, center)
    end

    def focus1
      discriminating(
          lambda {Point.new(x: center.x + cx, y: center.y)},
          lambda {Point.new(x: center.x, y: center.y + cy)}
      )
    end

    def focus2
      discriminating(
          lambda {Point.new(x: center.x - cx, y: center.y)},
          lambda {Point.new(x: center.x, y: center.y - cy)}
      )
    end

    def distance
      discriminating(lambda {2 * a}, lambda {2 * b})
    end

    def focal_axis
      Segment.new(extreme1: focus1, extreme2: focus2)
    end

    def major_axis
      discriminating(
          lambda {Segment.new(extreme1: Point.new(x: center.x - a, y: center.y), extreme2: Point.new(x: center.x + a, y: center.y))},
          lambda {Segment.new(extreme1: Point.new(x: center.x, y: center.y - b), extreme2: Point.new(x: center.x, y: center.y + b))},
      )
    end

    def minor_axis
      discriminating(
          lambda {Segment.new(extreme1: Point.new(x: center.x, y: center.y - b), extreme2: Point.new(x: center.x, y: center.y + b))},
          lambda {Segment.new(extreme1: Point.new(x: center.x - a, y: center.y), extreme2: Point.new(x: center.x + a, y: center.y))}
      )
    end

    def vertices
      [
          Point.new(x: center.x + a, y: center.y),
          Point.new(x: center.x, y: center.y - b),
          Point.new(x: center.x - a, y: center.y),
          Point.new(x: center.x, y: center.y + b)
      ]
    end

    def eccentricity
      Rational(focal_axis.length, major_axis.length)
    end

    def congruent?(ellipse)
      ellipse.instance_of?(Ellipse) and
          ellipse.eccentricity == self.eccentricity
    end

    def == (ellipse)
      ellipse.instance_of?(Ellipse) and
          ellipse.focus1 == self.focus1 and ellipse.focus2 == self.focus2 and ellipse.distance == self.distance
    end

    private

    def validation
      if @x2_coeff <= 0 or @y2_coeff <= 0 or @x2_coeff == @y2_coeff or determinator <= @k_coeff
        raise ArgumentError.new('Invalid coefficients!')
      end
    end

    def self.build_by(a2, b2, center)
      self.new(x2: b2, y2: a2, x: -2 * b2 * center.x, y: -2 * a2 * center.y, k: b2 * center.x ** 2 + a2 * center.y ** 2 - a2 * b2)
    end

    def discriminating(horizontal_focus_type, vertical_focus_type)
      if a2 > b2
        horizontal_focus_type.call
      else
        vertical_focus_type.call
      end
    end

    def a
      Math.sqrt(a2)
    end

    def b
      Math.sqrt(b2)
    end

    def cx
      Math.sqrt(a2 - b2)
    end

    def cy
      Math.sqrt(b2 - a2)
    end

  end

end