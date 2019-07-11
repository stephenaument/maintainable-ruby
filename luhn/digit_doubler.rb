# Class responsible for doubling a digit in a luhn string. If the result
# is double-digits, subtract 9 from the results.
class DigitDoubler
  MAX_DIGIT = 9

  attr_reader :digit

  def initialize(digit)
    @digit = digit
  end

  class << self
    def double(digit)
      new(digit).double
    end
  end

  def double
    return unless digit
    double_digits? ? doubled_digit - MAX_DIGIT : doubled_digit
  end

  def double_digits?
    doubled_digit > MAX_DIGIT
  end

  def doubled_digit
    @doubled_digit ||= Integer(digit) * 2
  end
end
