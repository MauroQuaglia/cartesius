require('cartesius/validator')
require('cartesius/segment')
require('cartesius/angle')

module Cartesius

  class Triangle

    def initialize(a:, b:, c:)
      validation(a, b, c)

      @v_a = a
      @v_b = b
      @v_c = c

      @s_a = Segment.new(extreme1: @v_b, extreme2: @v_c)
      @s_b = Segment.new(extreme1: @v_a, extreme2: @v_c)
      @s_c = Segment.new(extreme1: @v_a, extreme2: @v_b)

      @a_a = Angle.by_radiants(carnot(@s_a, @s_b, @s_c))
      @a_b = Angle.by_radiants(carnot(@s_b, @s_a, @s_c))
      @a_c = Angle.by_radiants(carnot(@s_c, @s_a, @s_b))
    end

    def angles
      {a: @a_a, b: @a_b, c: @a_c}
    end

    def sides
      {a: @s_a, b: @s_b, c: @s_c}
    end

    def vertices
      {a: @v_a, b: @v_b, c: @v_c}
    end

    def rectangle?
      angles.values.any? {|angle| angle.right?}
    end

    def obtuse?
      angles.values.any? {|angle| angle.obtuse?}
    end

    def acute?
      not rectangle? and not obtuse?
    end

    def == (triangle)
      triangle.instance_of?(self.class) and
          triangle.vertices.values.to_set == self.vertices.values.to_set
    end

    def congruent? (triangle)
      triangle.instance_of?(self.class) and
          sides_length(triangle) == sides_length(self)
    end

    private

    def carnot(side1, side2, side3)
      cosine = Rational(
          side2.length ** 2 + side3.length ** 2 - side1.length ** 2,
          2 * side2.length * side3.length
      )
      Math.acos(cosine)
    end

    def validation(a, b, c)
      Validator.same_points([a, b, c])
      Validator.aligned_points([a, b, c])
    end

    def sides_length(triangle)
      triangle.sides.values.collect {|side| side.length}.sort
    end

  end

end