require_relative('../models/conic')
require_relative('../../../lib/conics/modules/determinator')

module Conics

  class Ellipse < Conic
    include Determinator

    # Conic
    # Conic equation type: ax^2 + by^2 + dx + ey + f = 0
    def initialize(x2:, y2:, x:, y:, k:)
      super(x2: x2, y2: y2, xy: 0, x: x, y: y, k: k)
      validation
    end

    def self.by_definition(focus1:, focus2:, sum_of_distances:)
      # TODO add pre-execution
      
      center = Point.mid(point1: focus1, point2: focus2)
      focal_distance = Point.distance(point1: focus1, point2: focus2)

      if focus1.aligned_horizontally_with?(focus2)
        x_half_axis_length_squared = Rational(sum_of_distances, 2) ** 2
        y_half_axis_length_squared = x_half_axis_length_squared - Rational(focal_distance, 2) **2
      end

      if focus1.aligned_vertically_with?(focus2)
        y_half_axis_length_squared = Rational(sum_of_distances, 2)
        x_half_axis_length_squared = y_half_axis_length_squared - Rational(focal_distance, 2) **2
      end

      self.(
          x2: y_half_axis_length_squared,
              y2: x_half_axis_length_squared,
              x: -2 * y_half_axis_length_squared * center.x,
              y: -2 * x_half_axis_length_squared * center.y,
              k: y_half_axis_length_squared * center.x ** 2 + x_half_axis_length_squared * center.y ** 2 - x_half_axis_length_squared * y_half_axis_length_squared)
    end

    private

    def validation

      if @x2_coeff <= 0 or @y2_coeff <= 0 or @x2_coeff == @y2_coeff or determinator <= @k_coeff
        coefficients_error
      end

    end
  end

end