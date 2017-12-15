module Numerificator

  private

  def equationfy(coefficients)
    coefficients.delete_if {|_, value| value.zero?}

    if coefficients.first.last < 0
      coefficients.each {|k, v| coefficients[k] = -v}
    end

    equation = []
    coefficients.each do |key, value|
      if key == '1'
        equation << [monomial(value)]
      else
        equation << [monomial(value, key)]
      end
    end
    equation << ['=', '0']

    equation.join(' ')
  end

  def stringfy(number)
    if number.denominator == 1
      return number.numerator.to_s
    end
    number.to_s
  end

  # TODO: test
  def numberfy(numerator, denominator)
    if denominator == 1
      numerator
    elsif denominator == -1
      -numerator
    else
      Rational(numerator, denominator)
    end
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

  def normalize(*coefficients)
    sign = signum(coefficients.first.to_r)
    coefficients.map! {|coefficient| sign * coefficient.to_r}
  end


end