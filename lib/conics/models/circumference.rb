require_relative('../models/conic')
require_relative('../../../lib/conics/modules/determinator')

module Conics

  class Circumference < Conic
    include Determinator

    # Conic
    # Conic equation type: x^2 + y^2 + dx + ey + f = 0
    def initialize(x:, y:, k:)
      super(x2: 1, y2: 1, xy: 0, x: x, y: y, k: k)
      validation
    end

    def self.unitary
      new(x: 0, y: 0, k: -1)
    end

    def center
      Point.create(x: centrum[:xc], y: centrum[:yc])
    end

    def radius
      Math.sqrt(x_half_axis_squared)
    end

    def unitary?
      self == Circumference.unitary
    end

    # TODO: To test when i can create some circunferences.
    def == (circumference)
      circumference.instance_of?(Circumference) and
          circumference.center == self.center and circumference.radius == self.radius
    end

    private

    def validation
      if determinator <= @k_coeff
        coefficients_error
      end
    end

  end
end