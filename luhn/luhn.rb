class LuhnValidator
  attr_reader :luhn_number

  def initialize(luhn_number)
    @luhn_number = normalize luhn_number
  end

  class << self
    def valid?(luhn_number)
      new(luhn_number).valid?
    end
  end

  def algorithm_matched?
    luhn_number.split('').reverse.each_with_index.map do |digit, index|

      digit = digit.to_i
      if index.odd?
        digit *= 2
        digit -= 9 if digit > 9
      end
      digit
    end
      .sum % 10 == 0
  end

  def invalid_characters?
    luhn_number =~ /\D/
  end

  def too_short?
    luhn_number.length <= 1
  end

  def valid?
    return false if too_short?
    return false if invalid_characters?

    algorithm_matched?
  end

private

  def normalize(input)
    input.gsub(/\s/, '')
  end
end
