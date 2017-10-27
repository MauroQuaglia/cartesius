require_relative('../../../lib/cartesius/models/point')
require_relative('../../../lib/cartesius/models/line')

module Cartesius

  class Segment
    attr_reader :extreme1, :extreme2

    def initialize(extreme1, extreme2)
      @extreme1, @extreme2 = extreme1, extreme2
      validation
    end

    def horizontal?
      line.horizontal?
    end

    def vertical?
      line.vertical?
    end

    def length
      Point.distance(@extreme1, @extreme2)
    end

    def mid
      Point.new(
          x: Rational(@extreme1.x + @extreme2.x, 2),
          y: Rational(@extreme1.y + @extreme2.y, 2)
      )
    end

    def to_equation
      line.to_equation
    end

    private

    def validation
      if @extreme1 == @extreme2
        raise ArgumentError.new('Extremes cannot be the same!')
      end
    end

    def line
      Line.by_points(point1: @extreme1, point2: @extreme2)
    end

  end

end