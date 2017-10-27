require_relative('../../../lib/cartesius/modules/numerificator')

class Conic
  include Numerificator

  # Conic equation type: ax^2 + by^2 + cxy + dx + ey + f = 0
  def initialize(x2:, y2:, xy:, x:, y:, k:)
    @x2_coeff, @y2_coeff, @xy_coeff = x2.to_r, y2.to_r, xy.to_r
    @x_coeff, @y_coeff = x.to_r, y.to_r
    @k_coeff = k.to_r
  end


  def to_s
    "x^2: #{@x2_coeff}, y^2: #{@y2_coeff}, xy: #{@xy_coeff}, x: #{@x_coeff}, y: #{@y_coeff}, k: #{@k_coeff}"
  end

  private

  def coefficients_error
    raise ArgumentError.new('Invalid coefficients!')
  end

end

