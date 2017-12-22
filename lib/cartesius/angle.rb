module Cartesius
  class Angle
    #enum angle: [:acute, :obtuse, :right]

    # OK
    private_class_method(:new)

    def initialize(angle)
      @angle = angle
    end

    # Vedere se si può togliere il return
    def self.by_lines(line1:, line2:, type: :acute)
      if line1 == line2
       return new(0) if type == :acute
       return new(180) if type == :obtuse
       raise ArgumentError
      else

      end
    end

    def self.by_degrees
    end

    def self.by_radiants
    end

    def self.right
      new(90)
    end

    def self.null
      new(0)
    end

    def null?
    end

    def right?
    end

    def flat?
    end

    def full?
    end

    def acute?
    end

    def obtuse?
    end

    def degrees
    end

    def radiants
    end

    def congruent?(angle)
    end

  end
end