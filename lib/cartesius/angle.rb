module Cartesius
  class Angle

    private_class_method(:new)

    def initialize(angle)
      @angle = angle
    end

    def self.by_degrees(degrees)
      new(degrees)
    end

    def self.by_radiants(radiants)
      new(Rational(radiants * 180, Math::PI))
    end

    def degrees
      @angle.to_f
    end

    def radiants
      Rational(@angle * Math::PI, 180).to_f
    end

  end
end