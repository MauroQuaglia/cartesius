require_relative('../models/conic')
require_relative('../../lib/modules/determinator')

class Ellipse < Conic
  include Determinator

  # Conic
  # Conic equation type: ax^2 + by^2 + dx + ey + f = 0
  def initialize(x2:, y2:, x:, y:, k:)
    super(x2: x2, y2: y2, xy: 0, x: x, y: y, k: k)
    validation
  end

  # TODO: To test when i can create some circunferences.
  def == (ellipse)
  end

  private

  def validation
  end

end