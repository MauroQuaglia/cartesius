require_relative('../models/conic')

class Line < Conic
  attr_reader :slope, :known_term
  VERTICAL_SLOPE = Float::INFINITY
  HORIZONTAL_SLOPE = 0

  # Degenerate conic
  # Conic equation type: dx + ey + f = 0
  def initialize(x:, y:, k:)
    super(x2: 0, y2: 0, xy: 0, x: x, y: y, k: k)
    build
  end

  # TODO: Usare un case.
  def self.create(slope:, known_term:)
    if slope == HORIZONTAL_SLOPE
      return self.new(x: 0, y: 1, k: -known_term)
    end

    if slope == VERTICAL_SLOPE
      return self.new(x: 1, y: 0, k: -known_term)
    end

    self.new(x: -slope, y: 1, k: -known_term)
  end

  def self.horizontal(known_term:)
  end

  def self.vertical(known_term:)
  end

  def horizontal?
  end

  def vertical?
  end

  def inclined?
  end

  def == (line)
    #line.instance_of?(Line)
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