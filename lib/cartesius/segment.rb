require('cartesius/point')
require('cartesius/line')

module Cartesius

  class Segment
    include Numerificator
    extend Forwardable
    attr_reader :extreme1, :extreme2
    def_delegators(:@line, :horizontal?, :vertical?, :inclined?, :ascending?, :descending?)

    def initialize(extreme1:, extreme2:)
      @extreme1, @extreme2 = extreme1, extreme2
      validation
      @line = Line.by_points(point1: @extreme1, point2: @extreme2)
    end

    def to_line
      @line
    end

    def length
      Point.distance(@extreme1, @extreme2)
    end

    def mid
      Point.new(
          x: numberfy(@extreme1.x + @extreme2.x, 2),
          y: numberfy(@extreme1.y + @extreme2.y, 2)
      )
    end

    def extremes
      [@extreme1, @extreme2]
    end

    def congruent?(segment)
      segment.instance_of?(self.class) &&
          segment.length == self.length
    end

    def == (segment)
      segment.instance_of?(self.class) && (
      (segment.extreme1 == extreme1 && segment.extreme2 == extreme2) ||
          (segment.extreme1 == extreme2 && segment.extreme2 == extreme1)
      )
    end

    alias_method(:eql?, :congruent?)

    private

    def validation
      if @extreme1 == @extreme2
        raise ArgumentError.new('Extremes cannot be the same!')
      end
    end

    def hash
      length.hash
    end

  end

end