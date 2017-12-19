module Validator

  private

  def same_points_validator(points)
    if points.count > 1 and points.count != points.to_set.count
      raise ArgumentError.new('Points are not distinct!')
    end
  end

  def aligned_points_validator(points)
    if points.count > 1 and points.count != points.to_set.count
      raise ArgumentError.new('Points are not distinct!')
    end
  end

end