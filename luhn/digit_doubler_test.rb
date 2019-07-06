require 'minitest/autorun'
require_relative './digit_doubler'

class DigitDoublerTest < Minitest::Test
  def test_4_returns_8
    assert DigitDoubler.double(4) == 8
  end

  def test_5_returns_1
    assert DigitDoubler.double(5) == 1
  end

  def test_nil_returns_nil
    assert DigitDoubler.double(nil) == nil
  end

  def test_string_accepted_as_input
    assert DigitDoubler.double('3') == 6
  end
end
