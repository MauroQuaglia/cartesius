module Normalizator

  def normalize(*coefficients)
    sign = signum(coefficients.first.to_r)
    coefficients.map! {|coefficient| sign * coefficient.to_r}
  end

end