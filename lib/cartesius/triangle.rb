require('cartesius/line')

module Cartesius

  class Triangle
    attr_reader(:v1, :v2, :v3)

    def initialize(v1:, v2:, v3:)
      @v1, @v2, @v3 = v1, v2, v3
      validation
    end

    private

    def validation
      if @v1 == @v2 or @v1 == @v3 or @v2 == @v3
        raise ArgumentError.new('Vertices must be different!')
      end
      if Line.by_points(point1: @v1, point2: @v2).include?(@v3)
        raise ArgumentError.new('Vertices must not be aligned!')
      end
    end

  end

end