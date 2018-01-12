require('cartesius/neighbourhoods')

module Cartesius
  class Angle
    TOLERANCE = Rational(1, 100)
    private_constant(:TOLERANCE)

    NULL, RIGHT, FLAT, FULL = 0, 90, 180, 360
    private_constant(:NULL)
    private_constant(:RIGHT)
    private_constant(:FLAT)
    private_constant(:FULL)

    def initialize(angle)
      validation(angle)
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

    def degrees
      @angle
    end

    def radiants(precision = 3)
      (@angle * Math::PI / FLAT).round(precision)
    end

    def null?
      OpenNeighbourhood.new(NULL, TOLERANCE).include?(degrees)
    end

    def acute?
      CloseNeighbourhood.new(45, 45 - TOLERANCE).include?(degrees)
    end

    def right?
      OpenNeighbourhood.new(RIGHT, TOLERANCE).include?(degrees)
    end

    def obtuse?
      CloseNeighbourhood.new(135, 45 - TOLERANCE).include?(degrees)
    end

    def flat?
      OpenNeighbourhood.new(FLAT, TOLERANCE).include?(degrees)
    end

    def full?
      OpenNeighbourhood.new(FULL, TOLERANCE).include?(degrees)
    end

    def congruent?(other)
      other.instance_of?(self.class) &&
          OpenNeighbourhood.new(NULL, TOLERANCE).include?((other.degrees - degrees).abs)
    end

    alias_method(:eql?, :congruent?)

    private

    def validation(angle)
      if angle < NULL || angle > FULL
        raise ArgumentError.new('Invalid angle!')
      end
    end

    def hash
      @angle.hash
    end

  end
end