require('set')
require('cartesius/point')
require('cartesius/line')

module Cartesius

  class Segment
    extend Forwardable
    attr_reader :extreme1, :extreme2 # OK
    def_delegators(:@line, :horizontal?, :vertical?, :inclined?, :ascending?, :descending?) # OK

    # OK
    def initialize(extreme1:, extreme2:)
      @extreme1, @extreme2 = extreme1, extreme2
      validation
      @line = Line.by_points(point1: @extreme1, point2: @extreme2)
    end

    # OK
    def to_line
      @line
    end

    # OK
    def length
      Point.distance(@extreme1, @extreme2)
    end

    # OK
    def mid
      Point.new(
          x: Rational(@extreme1.x + @extreme2.x, 2),
          y: Rational(@extreme1.y + @extreme2.y, 2)
      )
    end

    def extremes
      [@extreme1, @extreme2]
    end

    # OK
    def congruent?(segment)
      segment.instance_of?(self.class) and
          segment.length == self.length
    end

    # OK
    def == (segment)
      segment.instance_of?(self.class) and (
      (segment.extreme1 == extreme1 and segment.extreme2 == extreme2) or
          (segment.extreme1 == extreme2 and segment.extreme2 == extreme1)
      )
    end

    private

    def validation
      if @extreme1 == @extreme2
        raise ArgumentError.new('Extremes cannot be the same!')
      end
    end

  end

end