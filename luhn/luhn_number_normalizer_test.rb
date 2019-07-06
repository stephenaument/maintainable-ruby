require 'minitest/autorun'
require_relative './luhn_number_normalizer'

class LuhnNumberNormalizerTest < Minitest::Test
  def test_spaces_are_removed
    assert LuhnNumberNormalizer.new('0 1 2').normalize == '012'
  end

  def test_forces_to_string
    assert LuhnNumberNormalizer.new(123).normalize == '123'
  end

  def test_nil
    assert LuhnNumberNormalizer.new(nil).normalize == ''
  end

  def test_convenience_method
    assert LuhnNumberNormalizer.normalize('1 2 34') == '1234'
  end
end
