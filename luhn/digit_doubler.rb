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
    Integer(digit) * 2
  end
end
