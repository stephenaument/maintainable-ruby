class LuhnValidator
  attr_reader :luhn_number

  def initialize(luhn_number)
    @luhn_number = luhn_number
  end

  class << self
    def valid?(luhn_number)
      new(luhn_number).valid?
    end
  end

  def valid?
    return false if luhn_number.gsub(/\s/, '').length <= 1
    return false if luhn_number.gsub(/\s/, '') =~ /\D/

    luhn_number.gsub(/\s/, '').split('').reverse.each_with_index.map do |digit, index|

      digit = digit.to_i
      if index.odd?
        digit *= 2
        digit -= 9 if digit > 9
      end
      digit
    end
      .sum % 10 == 0
  end
end
