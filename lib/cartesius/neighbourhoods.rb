class OpenNeighbourhood
  def initialize(center, width)
    @center = center
    @width = width
  end

  def include?(value)
    (value > @center - @width) && (value < @center + @width)
  end
end

class CloseNeighbourhood
  def initialize(center, width)
    @center = center
    @width = width
  end

  def include?(value)
    (value >= @center - @width) && (value <= @center + @width)
  end
end