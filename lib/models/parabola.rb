require_relative('../models/conic')
require_relative('../models/point')
require_relative('../models/line')

class Parabola < Conic

  # Conic
  # Conic equation type: ax^2 + dx - y + f = 0
  def initialize(x2:, x:, k:)
    super(x2: x2, y2: 0, xy: 0, x: x, y: -1, k: k)
    validation
  end

  def self.unitary_convex
    new(x2: 1, x: 0, k: 0)
  end

  def self.unitary_concave
    new(x2: -1, x: 0, k: 0)
  end

  def directrix
    Line.horizontal(known_term: Rational(-delta - 1, 4 * @x2_coeff))
  end

  def focus
    Point.create(x: Rational(-@x_coeff, 2 * @x2_coeff), y: Rational(1 - delta, 4 * @x2_coeff))
  end

  def vertex
    Point.create(x: Rational(-@x_coeff, 2 * @x2_coeff), y: Rational(-delta, 4 * @x2_coeff))
  end

  def symmetry_axis
    Line.vertical(known_term: Rational(-@x_coeff, 2* @x2_coeff))
  end

  def unitary_convex?
    self == Parabola.unitary_convex
  end

  def unitary_concave?
    self == Parabola.unitary_concave
  end

  # TODO: To test when i can create some circunferences.
  def == (parabola)
    parabola.instance_of?(Parabola) and
        parabola.focus == self.focus and parabola.directrix == self.directrix
  end

  private

  def validation
    if @x2_coeff == 0
      coefficients_error
    end
  end

  def delta
    (@x_coeff ** 2) - (4 * @x2_coeff * @k_coeff)
  end

end