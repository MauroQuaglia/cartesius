require_relative('../models/conic')

module Conics

  class Homography < Conic

    # Conic
    # Conic equation type: xy + dx + ey + f = 0
    def initialize(x:, y:, k:)
      super(x2: 0, y2: 0, xy: 1, x: x, y: y, k: k)
      validation
    end

    private

    def validation

      if @k_coeff == @x_coeff * @y_coeff
        coefficients_error
      end

    end

  end

end