module Numerificator

  private

  def stringfy(number)
    if number.denominator == 1
      return number.numerator.to_s
    end
    number.to_s
  end

  def monomial(number_part, letter_part = nil)
    number_string = if number_part.denominator == 1
                      number_part.numerator.abs.to_s
                    else
                      "(#{number_part.abs.to_s})"
                    end
    "#{signum_symbol(number_part)}#{number_string}#{letter_part}"
  end

  def signum(number)
    number < 0 ? -1 : 1
  end

  def signum_symbol(number)
    number >= 0 ? '+' : '-'
  end

end