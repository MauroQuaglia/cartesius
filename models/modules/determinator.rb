module Determinator

  private

  def center
    {
        xc: numberfy(-@x_coeff, 2 * @x2_coeff),
        yc: numberfy(-@y_coeff, 2 * @y2_coeff),
    }
  end

end