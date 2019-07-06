require_relative './array'
require_relative './integer'
require_relative './luhn_number_normalizer'

class LuhnValidator
  INVALID_CHARACTERS = /\D/
  MINIMUM_LENGTH = 2

  attr_reader :luhn_number

  def initialize(luhn_number)
    @luhn_number = LuhnNumberNormalizer.normalize luhn_number
  end

  class << self
    def valid?(luhn_number)
      new(luhn_number).valid?
    end
  end

  def algorithm_matched?
    digit_sum_after_doubling.divisible_by? 10
  end

  def invalid_characters?
    luhn_number =~ INVALID_CHARACTERS
  end

  def digits
    luhn_number.split('').map(&:to_i)
  end

  def digits_after_doubling
    digits.reverse.each_pair.map do |first, second|
      [first, DigitDoubler.double(second)].compact
    end.flatten.reverse
  end

  def digit_sum_after_doubling
    digits_after_doubling.sum
  end

  def too_short?
    luhn_number.length < MINIMUM_LENGTH
  end

  def valid?
    return false if too_short?
    return false if invalid_characters?

    algorithm_matched?
  end

private

  def double(digit)
    return unless digit
    digit *= 2
    digit -= 9 if digit > 9
    digit
  end
end
