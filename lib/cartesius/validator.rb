require('cartesius/line')

module Cartesius

  class Validator
    def self.same_points(points)
      if points.count != points.to_set.count
        raise ArgumentError.new('Points must be distinct!')
      end
    end

    # TODO: cambiare nome... ne bastano 3 allineati, ma se sono 4 per eccezione ne bastano tre allineati.
    def self.aligned_points(points)
      if points.count >= 3
        line = Line.by_points(point1: points.shift, point2: points.pop)
        points.each do |point|
          raise ArgumentError.new('Points must not be aligned!') if line.include?(point)
        end
      end
    end
  end

end