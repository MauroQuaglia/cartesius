module Numerificator

  def numberfy(numerator, denominator)
    if denominator == 1
      numerator
    else
      Rational(numerator, denominator)
    end
  end

  def stringfy(number)
  end
  
end