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

  def self.create(slope:, known_term:)
    new(x: -slope.to_r, y: 1, k: -known_term.to_r)
  end

  def self.horizontal(known_term:)
    new(x: 0, y: 1, k: -known_term.to_r)
  end

  def self.vertical(known_term:)
    new(x: 1, y: 0, k: -known_term.to_r)
  end

  def self.x_axis
    horizontal(known_term: 0)
  end

  def self.y_axis
    vertical(known_term: 0)
  end

  def self.ascending_bisector
    new(x: -1, y: 1, k: 0)
  end

  def self.descending_bisector
    new(x: 1, y: 1, k: 0)
  end

  def horizontal?
    @slope == HORIZONTAL_SLOPE
  end

  def vertical?
    @slope == VERTICAL_SLOPE
  end

  def == (line)
    line.instance_of?(Line) and line.slope == @slope and line.known_term == @known_term
  end

  private

  def build
    if (@x_coeff == 0 and @y_coeff == 0)
      raise ArgumentError.new('Invalid parameters!')
    end

    if @y_coeff == 0
      @slope = VERTICAL_SLOPE
      @known_term = numberfy(-@k_coeff, @x_coeff)
    else
      @slope = numberfy(-@x_coeff, @y_coeff)
      @known_term = numberfy(-@k_coeff, @y_coeff)
    end
  end

end