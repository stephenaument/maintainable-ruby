class DigitDoubler
  class << self
    def double(digit)
      return unless digit
      digit = Integer(digit)
      digit *= 2
      digit -= 9 if digit > 9
      digit
    end
  end
end
