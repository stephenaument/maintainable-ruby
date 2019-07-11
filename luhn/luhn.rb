require_relative './array'
require_relative './digit_doubler'
require_relative './integer'
require_relative './luhn_number_normalizer'

# The Luhn class determines whether the format of the given
# input string represents a valid number processable by the
# Luhn algorithm.
#
# LuhnValidator.valid?('055 444 285') #> true
# LuhnValidator.valid?('055 444 286') #> false
# LuhnValidator.new('8273 1232 7352 0569').valid? #> false
#
class LuhnValidator
  INVALID_CHARACTERS = /\D/
  LUHN_ALGORITHM_DIVISOR = 10
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
    digit_sum_after_doubling.divisible_by? LUHN_ALGORITHM_DIVISOR
  end

  def invalid_characters?
    luhn_number =~ INVALID_CHARACTERS
  end

  def digits
    luhn_number.each_char.map(&:to_i)
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
end
