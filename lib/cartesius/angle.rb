module Cartesius
  class Angle
    NULL, RIGHT, FLAT, FULL = 0, 90, 180, 360
    private_constant(:NULL)
    private_constant(:RIGHT)
    private_constant(:FLAT)
    private_constant(:FULL)

    def initialize(angle)
      @angle = angle
    end

    private_class_method(:new)

    def self.by_degrees(degrees)
      new(degrees)
    end

    def self.by_radiants(radiants)
      by_degrees(radiants * FLAT / Math::PI)
    end

    def self.by_lines(line1:, line2:)
      raise ArgumentError.new('Lines must not be parallel!') if line1.parallel?(line2)
      if line1.perpendicular?(line2)
        [right, right]
      else
        acute = by_radiants(Math.atan(line1.slope - line2.slope / 1 + line1.slope * line2.slope).abs)
        [acute, new(FLAT - acute.degrees)]
      end
    end

    def self.null
      by_degrees(NULL)
    end

    def self.right
      by_degrees(RIGHT)
    end

    def self.flat
      by_degrees(FLAT)
    end

    def self.full
      by_degrees(FULL)
    end

    def degrees(precision = 3)
      @angle.round(precision)
    end

    def radiants(precision = 3)
      (@angle * Math::PI / FLAT).round(precision)
    end

    def null?
      degrees == NULL
    end

    def acute?
      degrees > NULL and degrees < RIGHT
    end

    def right?
      degrees == RIGHT
    end

    def obtuse?
      degrees > RIGHT and degrees < FLAT
    end

    def flat?
      degrees == FLAT
    end

    def full?
      degrees == FULL
    end

    def congruent?(angle)
      angle.instance_of?(self.class) and
          angle.degrees == self.degrees
    end

    alias_method(:eql?, :congruent?)

    private

    def hash
      @angle.hash
    end

  end
end