require 'ostruct'
require 'minitest/autorun'
require_relative './match_scorer'

class MatchScorerTest < Minitest::Test
  def teams
    @teams ||= %w[pirates ninjas]
  end

  def match
    @match ||= OpenStruct.new teams: teams
  end

  def subject
    @subject ||= MatchScorer.new match
  end

  def team_stat_1
    @team_stat_1 ||= Minitest::Mock.new
  end

  def team_stat_2
    @team_stat_2 ||= Minitest::Mock.new
  end

  def team_stats
    @team_stats ||= [team_stat_1, team_stat_2]
  end

  def test_team_stats_initialization
    assert_equal 2, subject.team_stats.count
    assert_equal teams, subject.team_stats.map(&:name)
  end

  def test_draw_scorer_score_on_initialize
    do_test_scorer_score_on_initialize DrawScorer, :add_draw, :add_draw
  end

  def test_loss_scorer_score_on_initialize
    do_test_scorer_score_on_initialize LossScorer, :add_loss, :add_win
  end

  def test_wins_scorer_score
    do_test_scorer_score_on_initialize WinScorer, :add_win, :add_loss
  end

  def do_test_scorer_score_on_initialize(scorer_class, method_1, method_2)
    team_stat_1.expect method_1, nil
    team_stat_2.expect method_2, nil

    TeamStat.stub :new, proc { team_stats.shift } do
      scorer_class.new match
    end

    assert_mock team_stat_1
    assert_mock team_stat_2
  end
end
