module Numerificator

  def stringfy(number)
    if number.denominator == 1
      return number.numerator.to_s
    end
    number.to_s
  end

end