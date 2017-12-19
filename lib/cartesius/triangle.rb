require('cartesius/line')
require('cartesius/segment')

module Cartesius

  class Triangle
    attr_reader(:v1, :v2, :v3)
    attr_reader(:s12, :s13, :s23)

    # OK
    def initialize(v1:, v2:, v3:)
      validation(v1, v2, v3)
      @v1, @v2, @v3 = v1, v2, v3
      @s12 = Segment.new(extreme1: @v1, extreme2: @v2)
      @s13 = Segment.new(extreme1: @v1, extreme2: @v3)
      @s23 = Segment.new(extreme1: @v2, extreme2: @v3)
    end

    def vertices
      [@v1, @v2, @v3]
    end

    def sides
      [@s12, @s13, @s23]
    end


    #OK
    def == (triangle)
      triangle.instance_of?(self.class) and
          triangle.vertices.to_set == self.vertices.to_set
    end

    def congruent? (triangle)
      triangle.instance_of?(self.class) and
          sides_length(triangle) == sides_length(self)
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

    def sides_length(triangle)
      triangle.sides.collect {|side| side.length}.sort
    end

  end

end