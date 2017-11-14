module Determinator

  def center
    Cartesius::Point.new(
        x: Rational(-@x_coeff, (2 * @x2_coeff)),
        y: Rational(-@y_coeff, (2 * @y2_coeff))
    )
  end

  def to_equation
    equationfy(
        'x^2' => @x2_coeff, 'y^2' => @y2_coeff, 'x' => @x_coeff, 'y' => @y_coeff, '1' => @k_coeff
    )
  end

  private

  def a2
    Rational((determinator - @k_coeff).abs, (@x2_coeff).abs)
  end

  def b2
    Rational((determinator - @k_coeff).abs, (@y2_coeff).abs)
  end

  def determinator
    (@x2_coeff * (center.x**2)) + (@y2_coeff * (center.y**2))
  end

end