module NumberSupport

  def numberfy(numerator, denominator)
    if denominator == 1
      numerator
    else
      Rational(numerator, denominator)
    end
  end

end