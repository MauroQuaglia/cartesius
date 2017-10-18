require_relative('../../../lib/cartesius/modules/numerificator')

class Conic
  include Numerificator

  # Conic equation type: ax^2 + by^2 + cxy + dx + ey + f = 0
  def initialize(x2:, y2:, xy:, x:, y:, k:)
    @x2_coeff, @y2_coeff, @xy_coeff = x2.to_r, y2.to_r, xy.to_r
    @x_coeff, @y_coeff = x.to_r, y.to_r
    @k_coeff = k.to_r
  end

  def to_equation
    coefficients = {
        'x^2' => @x2_coeff, 'y^2' => @y2_coeff, 'xy' => @xy_coeff, 'x' => @x_coeff, 'y' => @y_coeff, '1' => @k_coeff
    }.delete_if {|_, value| value.zero?}

    if coefficients.first.last < 0
      coefficients.transform_values! {|value| -value}
    end

    equation = []
    coefficients.each do |key, value|
      if key == '1'
        equation << [monomial(value)]
      else
        equation << [monomial(value, key)]
      end
    end
    equation << ['=', '0']

    equation.join(' ')
  end

  private

  def coefficients_error
    raise ArgumentError.new('Invalid coefficients!')
  end

end

