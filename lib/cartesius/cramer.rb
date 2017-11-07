require('matrix')

class Cramer

  def self.solution1(row1, known_term)
    matrix = Matrix.rows([row1])

    determinant = matrix.determinant
    if determinant.zero?
      raise ArgumentError.new('The determinant is zero!')
    end

    x1 = Rational(
        Matrix.columns([known_term]).determinant,
        determinant
    )

    [x1]
  end

  def self.solution2(row1, row2, known_term)
    matrix = Matrix.rows([row1, row2])

    determinant = matrix.determinant
    if determinant.zero?
      raise ArgumentError.new('The determinant is zero!')
    end

    x1 = Rational(
        Matrix.columns([known_term, matrix.column(1)]).determinant,
        determinant
    )

    x2 = Rational(
        Matrix.columns([matrix.column(0), known_term]).determinant,
        determinant
    )

    [x1, x2]
  end

  def self.solution3(row1, row2, row3, known_term)
    matrix = Matrix.rows([row1, row2, row3])

    determinant = matrix.determinant
    if determinant.zero?
      raise ArgumentError.new('The determinant is zero!')
    end

    x1 = Rational(
        Matrix.columns([known_term, matrix.column(1), matrix.column(2)]).determinant,
        determinant
    )

    x2 = Rational(
        Matrix.columns([matrix.column(0), known_term, matrix.column(2)]).determinant,
        determinant
    )

    x3 = Rational(
        Matrix.columns([matrix.column(0), matrix.column(1), known_term]).determinant,
        determinant
    )

    [x1, x2, x3]
  end
end