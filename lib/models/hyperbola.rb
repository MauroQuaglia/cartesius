require_relative('../models/conic')
require_relative('../../lib/modules/determinator')

class Hyperbola < Conic
  include Determinator

  # Conic
  # Conic equation type: ax^2 + by^2 + dx + ey + f = 0
  def initialize(x2:, y2:, x:, y:, k:)
    super(x2: x2, y2: y2, xy: 0, x: x, y: y, k: k)
    validation
  end

  private

  def validation

    if signum(@x2_coeff * @y2_coeff) >= 0 or determinator == @k_coeff
      coefficients_error
    end

  end

end