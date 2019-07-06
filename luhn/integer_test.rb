require 'minitest/autorun'
require_relative 'integer'

class IntegerTest < Minitest::Test
  def test_20_is_divisible_by_10
    assert 20.divisible_by? 10
  end

  def test_20_is_not_divisible_by_3
    refute 20.divisible_by? 3
  end
end
