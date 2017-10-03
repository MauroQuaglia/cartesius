module Numerificator

  def numberfy(numerator, denominator)
    Rational(numerator, denominator)
  end

  def stringfy(number)
    if number.denominator == 1
      return number.numerator.to_s
    end
    number.to_s
  end

end