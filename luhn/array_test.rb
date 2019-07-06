require 'minitest/autorun'
require_relative './array'

class ArrayTest < Minitest::Test

  def test_returns_pairs
    assert [1,2,3,4,5,6,7].each_pair.to_a == [[1,2],[3,4],[5,6],[7]]
  end
end
