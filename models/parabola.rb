require_relative('../models/conic')

class Parabola < Conic

  # Conic
  # Conic equation type: ax^2 + dx - y + f = 0
  def initialize(x2:, x:, k:)
    super(x2: x2, y2: 0, xy: 0, x: x, y: -1, k: k)
    build
  end

  private

  def build
  end

end