module Cartesius

  class Segment

    def initialize
    end

    #TODO length
    def self.distance(p1:, p2:)
      Math.sqrt((p1.x - p2.x) ** 2 + (p1.y - p2.y) ** 2)
    end

    # TODO in segment
    def self.mid(point1:, point2:)
      create(x: Rational(point1.x + point2.x, 2), y: Rational(point1.y + point2.y, 2))
    end

    def to_equation
    end

  end

end