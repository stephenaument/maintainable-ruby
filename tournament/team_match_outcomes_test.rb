require 'minitest/autorun'
require_relative './team_match_outcome'
require_relative './team_match_outcomes'

class TeamMatchOutcomesTest < Minitest::Test
  def outcomes
    @outcomes ||= [
      TeamMatchOutcome.new(:win, 3),
      TeamMatchOutcome.new(:win, 3),
      TeamMatchOutcome.new(:loss),
      TeamMatchOutcome.new(:loss),
      TeamMatchOutcome.new(:loss),
      TeamMatchOutcome.new(:draw, 1),
      TeamMatchOutcome.new(:draw, 1),
      TeamMatchOutcome.new(:draw, 1),
      TeamMatchOutcome.new(:draw, 1),
    ]
  end

  def more_outcomes
    @more_outcomes ||= [
      TeamMatchOutcome.new(:win, 3),
      TeamMatchOutcome.new(:loss),
      TeamMatchOutcome.new(:loss),
      TeamMatchOutcome.new(:draw, 1),
      TeamMatchOutcome.new(:draw, 1),
      TeamMatchOutcome.new(:draw, 1),
    ]
  end

  def subject
    @subject ||= TeamMatchOutcomes.new outcomes
  end

  def another_team_match_outcomes
    @another_team_match_outcomes ||= TeamMatchOutcomes.new more_outcomes
  end

  def test_outcomes_defaults_to_empty_array
    assert_equal TeamMatchOutcomes.new.outcomes, []
  end

  def test_outcomes_returns_what_was_passed_in
    assert_equal subject.outcomes, outcomes
  end

  def test_draws
    assert_equal subject.draws, 4
  end

  def test_losses
    assert_equal subject.losses, 3
  end

  def test_wins
    assert_equal subject.wins, 2
  end

  def test_matches_played
    assert_equal subject.matches_played, 9
  end

  def test_points
    assert_equal subject.points, 10
  end

  def test_addition_combines_outcomes
    assert_equal (subject + another_team_match_outcomes).outcomes, outcomes + more_outcomes
  end

  def test_addition_returns_a_new_object
    refute_equal (subject + another_team_match_outcomes), subject
  end

  def test_shovel
    new_outcome = TeamMatchOutcome.new(:bob)
    subject << new_outcome
    assert subject.outcomes.include? new_outcome
  end
end
