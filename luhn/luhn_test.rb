require 'minitest/autorun'
require_relative 'luhn'

# Common test data version: 1.4.0 4a80663
class LuhnTest < Minitest::Test

  def test_nil_is_invalid
    refute LuhnValidator.valid?(nil)
  end

  def test_single_digit_strings_can_not_be_valid
    refute LuhnValidator.valid?("1")
  end

  def test_a_single_zero_is_invalid
    refute LuhnValidator.valid?("0")
  end

  def test_a_simple_valid_sin_that_remains_valid_if_reversed
    assert LuhnValidator.valid?("059")
  end

  def test_a_simple_valid_sin_that_becomes_invalid_if_reversed
    assert LuhnValidator.valid?("59")
  end

  def test_a_valid_canadian_sin
    assert LuhnValidator.valid?("055 444 285")
  end

  def test_invalid_canadian_sin
    refute LuhnValidator.valid?("055 444 286")
  end

  def test_invalid_credit_card
    refute LuhnValidator.valid?("8273 1232 7352 0569")
  end

  def test_valid_number_with_an_even_number_of_digits
    assert LuhnValidator.valid?("095 245 88")
  end

  def test_valid_strings_with_a_non_digit_included_become_invalid
    refute LuhnValidator.valid?("055a 444 285")
  end

  def test_valid_strings_with_a_non_digit_added_at_the_end_become_invalid
    refute LuhnValidator.valid?("059a")
  end

  def test_valid_strings_with_punctuation_included_become_invalid
    refute LuhnValidator.valid?("055-444-285")
  end

  def test_valid_strings_with_symbols_included_become_invalid
    refute LuhnValidator.valid?("055£ 444$ 285")
  end

  def test_single_zero_with_space_is_invalid
    refute LuhnValidator.valid?(" 0")
  end

  def test_more_than_a_single_zero_is_valid
    assert LuhnValidator.valid?("0000 0")
  end

  def test_input_digit_9_is_correctly_converted_to_output_digit_9
    assert LuhnValidator.valid?("091")
  end

  def test_strings_with_non_digits_is_invalid
    refute LuhnValidator.valid?(":9")
  end
end
