#require('bigdecimal')

module Cartesius
  class Angle

    def initialize(angle)
      @angle = angle
    end

    private_class_method(:new)

    def self.by_degrees(degrees)
      new(degrees.to_r)
    end

    def self.by_radiants(radiants)
      new(Rational(radiants.to_r * 180, Math::PI))
    end

    def degrees(precision = 3)
      @angle.round(precision)
    end

    def radiants(precision = 3)
      Rational(@angle * Math::PI, 180).round(precision)
    end

    def null?
      self.degrees == 0
    end

    def acute?
      self.degrees > 0 and self.degrees < 90
    end

    def right?
      self.degrees == 90
    end

    def obtuse?
      self.degrees > 90 and self.degrees < 180
    end

    def flat?
      self.degrees == 180
    end

    def full?
      self.degrees == 360
    end

    def congruent?(angle)
      angle.instance_of?(self.class) and
          angle.degrees == self.degrees
    end

  end
end