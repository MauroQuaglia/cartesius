module NumberSupport

  # TODO: test
  def stringfy(number)
    if number.denominator == 1
      "#{sign(number)}#{number.numerator.abs.to_s}"
    else
      "#{sign(number)}(#{number.abs.to_s})"
    end
  end

  # TODO: test
  def numberfy(number)
    if number.denominator == 1
      number.numerator
    else
      number
    end
  end

  # TODO: test
  def sign(number)
    if number == 0
      return ''
    end
    number >= 0 ? '+' : '-'
  end

end