require('cartesius/validator')
require('cartesius/line')
require('cartesius/segment')

module Cartesius

  class Triangle
    include Validator
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

    #OK
    def congruent? (triangle)
      triangle.instance_of?(self.class) and
          sides_length(triangle) == sides_length(self)
    end

    private

    def validation(v1, v2, v3)
      same_points_validator([v1, v2, v3])

      if Line.by_points(point1: v1, point2: v2).include?(v3)
        raise ArgumentError.new('Vertices must not be aligned!')
      end
    end

    def sides_length(triangle)
      triangle.sides.collect {|side| side.length}.sort
    end

  end

end