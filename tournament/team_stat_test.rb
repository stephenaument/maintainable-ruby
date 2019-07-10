require 'ostruct'
require 'minitest/autorun'
require_relative './team_stat'

class TeamStatTest < Minitest::Test
  def team_match_outcomes
    @team_match_outcomes ||= OpenStruct.new(draws: 2, losses: 1, wins: 3, matches_played: 6, points: 11)
  end

  def another_team_match_outcomes
    @another_team_match_outcomes ||= Object.new
  end

  def subject
    @subject ||= TeamStat.new(name: 'fred', team_match_outcomes: [])
  end

  def test_initialize_defaults_team_match_outcomes
    TeamMatchOutcomes.stub :new, team_match_outcomes do
      assert_equal team_match_outcomes, TeamStat.new(name: 'foo').team_match_outcomes
    end
  end

  def test_initialize_accepts_a_team_match_outcomes
    TeamMatchOutcomes.stub :new, team_match_outcomes do
      assert_equal TeamStat.new(name: 'foo',
                                team_match_outcomes: another_team_match_outcomes)
        .team_match_outcomes, another_team_match_outcomes
    end
  end

  def test_field_values
    subject = TeamStat.new name: 'fred', team_match_outcomes: team_match_outcomes
    assert_equal ['fred', 6, 3, 2, 1, 11], subject.field_values
  end

  def test_add_draw
    subject.add_draw
    assert_equal 1, subject.team_match_outcomes.length
    assert subject.team_match_outcomes.first.draw?
  end

  def test_add_loss
    subject.add_loss
    assert_equal 1, subject.team_match_outcomes.length
    assert subject.team_match_outcomes.first.loss?
  end

  def test_add_win
    subject.add_win
    assert_equal 1, subject.team_match_outcomes.length
    assert subject.team_match_outcomes.first.win?
  end

  def test_to_str
    subject = TeamStat.new name: 'fred', team_match_outcomes: team_match_outcomes
    assert_equal "fred                           |  6 |  3 |  2 |  1 | 11\n",
                  subject.to_str
  end

  def test_plus
    subject = TeamStat.new name: 'fred', team_match_outcomes: [1,2]
    another_team_stat = TeamStat.new name: 'fred',
                        team_match_outcomes: [3,4]

    assert_equal [1,2,3,4], (subject + another_team_stat).team_match_outcomes
  end
end
