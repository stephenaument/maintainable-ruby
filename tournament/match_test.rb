require 'minitest/autorun'
require_relative './match'

class MatchTest < Minitest::Test
  def mbl_scorer
    MblScorer.new
  end

  def subject
    MatchScorerFactory.stub :scorer, mbl_scorer do
      Match.new('tofino;ucluelet;mbl')
    end
  end

  def test_result
    assert_equal 'mbl', subject.result
  end

  def test_teams
    assert_equal %w[tofino ucluelet], subject.teams
  end

  def test_team_stats
    assert_equal 'middle beach lodge', subject.team_stats
  end
end

class MblScorer
  def team_stats; 'middle beach lodge'; end
end
