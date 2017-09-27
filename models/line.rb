require_relative('../models/conic')

class Line < Conic
  attr_reader :slope, :known_term
  VERTICAL_SLOPE = Float::INFINITY

  # Degenerate conic
  # Conic equation type: dx + ey + f = 0
  def initialize(x:, y:, k:)
    super(x2: 0, y2: 0, xy: 0, x: x, y: y, k: k)
    build
  end

  private

  def build
    if (@x_coeff == 0 and @y_coeff == 0)
      raise ArgumentError.new('Invalid parameters!')
    end

    if @y_coeff == 0
      @slope = VERTICAL_SLOPE
      @known_term = Rational(-@k_coeff, @x_coeff)
    else
      @slope = Rational(-@x_coeff, @y_coeff)
      @known_term = Rational(-@k_coeff, @y_coeff)
    end
  end

end