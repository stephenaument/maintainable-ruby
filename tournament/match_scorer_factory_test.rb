require 'ostruct'
require 'minitest/autorun'
require_relative 'match_scorer_factory'

class MatchScorerFactoryTest < Minitest::Test
  def foo_match
    OpenStruct.new result: 'foo'
  end

  def bar_match
    OpenStruct.new result: 'bar'
  end

  def test_scorer
    assert_equal 'FooScorer', MatchScorerFactory.scorer(foo_match).class.name
    assert_equal 'BarScorer', MatchScorerFactory.scorer(bar_match).class.name
  end
end

class FooScorer
  def initialize(match);end
end

class BarScorer < FooScorer; end
