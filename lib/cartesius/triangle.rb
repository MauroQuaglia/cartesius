require('cartesius/line')
require('cartesius/segment')

module Cartesius

  class Triangle
    attr_reader(:vertex1, :vertex2, :vertex3)
    attr_reader(:side12, :side13, :side23)

    def initialize(vertex1:, vertex2:, vertex3:)
      validation(vertex1, vertex2, vertex3)
      @vertex1, @vertex2, @vertex3 = vertex1, vertex2, vertex3
      @side12 = Segment.new(extreme1: @vertex1, extreme2: @vertex2)
      @side13 = Segment.new(extreme1: @vertex1, extreme2: @vertex3)
      @side23 = Segment.new(extreme1: @vertex2, extreme2: @vertex3)
    end

    def vertices
      [@vertex1, @vertex2, @vertex3]
    end

    def sides
      [@side12, @side13, @side23]
    end

    def congruent?(triangle)
      triangle.instance_of?(self.class)
    end

    private

    def validation(vertex1, vertex2, vertex3)
      if vertex1 == vertex2 or vertex1 == vertex3 or vertex2 == vertex3
        raise ArgumentError.new('Vertices must be different!')
      end
      if Line.by_points(point1: vertex1, point2: vertex2).include?(vertex3)
        raise ArgumentError.new('Vertices must not be aligned!')
      end
    end

  end

end