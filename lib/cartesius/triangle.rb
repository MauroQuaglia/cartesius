require('cartesius/validator')
require('cartesius/segment')

module Cartesius

  class Triangle

    # OK
    def initialize(a:, b:, c:)
      validation(a, b, c)
      @a, @b, @c = a, b, c
      @s_ab = Segment.new(extreme1: @a, extreme2: @b)
      @s_ac = Segment.new(extreme1: @a, extreme2: @c)
      @s_bc = Segment.new(extreme1: @b, extreme2: @c)
    end

    # TODO
    def angles
      {a: nil, b: nil, c: nil}
    end

    def sides
      {a: @s_bc, b: @s_ac, c: @s_ab}
    end

    def vertices
      {a: @a, b: @b, c: @c}
    end

    #OK
    def == (triangle)
      triangle.instance_of?(self.class) and
          triangle.vertices.values.to_set == self.vertices.values.to_set
    end

    #OK
    def congruent? (triangle)
      triangle.instance_of?(self.class) and
          sides_length(triangle) == sides_length(self)
    end

    private

    def validation(a, b, c)
      Validator.same_points([a, b, c])
      Validator.aligned_points([a, b, c])
    end

    def sides_length(triangle)
      triangle.sides.values.collect {|side| side.length}.sort
    end

  end

end