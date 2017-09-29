require_relative('../lib/number_support')

class Conic
  include NumberSupport

  # Conic equation type: ax^2 + by^2 + cxy + dx + ey + f = 0
  def initialize(x2:, y2:, xy:, x:, y:, k:)
    @x2_coeff, @y2_coeff, @xy_coeff = x2.to_r, y2.to_r, xy.to_r
    @x_coeff, @y_coeff = x.to_r, y.to_r
    @k_coeff = k.to_r
  end

end