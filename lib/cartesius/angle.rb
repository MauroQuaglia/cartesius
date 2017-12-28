module Cartesius
  class Angle

    # OK
    private_class_method(:new)

    def initialize(angle)
      @angle = angle
    end

    # Vedere se si può togliere il return
    def self.by_lines(line1:, line2:, type: :acute)
      case
        when line1 == line2
          self.null if type == :acute
          self.flat if type == :obtuse
        when line1.perpendicular?(line2)
          self.right if type == :right
        when true
          self.right if type == :right
        else
          raise ArgumentError
      end

      if line1 == line2
        return self.null if type == :acute
        return self.flat if type == :obtuse
        raise ArgumentError
      elsif line1.parallel?(line2)
        raise ArgumentError
      elsif line1.perpendicular?(line2)
        return self.right if type == :right
        raise ArgumentError
      elsif true
        #calcolo
      else
        #eccezione
      end

    end

    def self.by_degrees
    end

    def self.by_radiants
    end

    def self.null
      new(0)
    end

    def self.right
      new(90)
    end

    def self.flat
      new(180)
    end

    def self.full
      new(360)
    end

    def degrees
    end

    def radiants
    end

    def congruent?(angle)
    end

  end
end