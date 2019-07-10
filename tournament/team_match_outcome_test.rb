require 'minitest/autorun'
require_relative './team_match_outcome'

class TeamMatchOutcomeTest < Minitest::Test
  def test_points
    assert_equal TeamMatchOutcome.new(:foo, 10).points, 10
  end

  def test_outcome
    assert_equal TeamMatchOutcome.new(:bar).outcome, :bar
  end

  def test_draw?
    tmo = TeamMatchOutcome.new(:draw)
    assert tmo.draw?
    refute tmo.loss?
    refute tmo.win?
  end

  def test_loss?
    tmo = TeamMatchOutcome.new(:loss)
    refute tmo.draw?
    assert tmo.loss?
    refute tmo.win?
  end

  def test_win?
    tmo = TeamMatchOutcome.new(:win)
    refute tmo.draw?
    refute tmo.loss?
    assert tmo.win?
  end

  def test_points_defaults_to_zero
    assert_equal TeamMatchOutcome.new(:zilch).points, 0
  end
end
