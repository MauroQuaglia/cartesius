module Determinator

  private

  def centrum
    {xc: Rational(-@x_coeff, (2 * @x2_coeff)), yc: Rational(-@y_coeff, (2 * @y2_coeff))}
  end

  def x_half_axis_squared
    Rational((determinator - @k_coeff).abs, (@x2_coeff).abs)
  end

  def y_half_axis_squared
    Rational((determinator - @k_coeff).abs, (@y2_coeff).abs)
  end

  def determinator
    (@x2_coeff * (centrum[:xc] ** 2)) + (@y2_coeff * (centrum[:yc] ** 2))
  end

end