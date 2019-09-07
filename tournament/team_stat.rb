require 'forwardable'
require_relative './team_match_outcome'
require_relative './team_match_outcome_collection'
require_relative './team_stat_comparator'

# An individual team tournament statistic set
class TeamStat
  extend Forwardable

  DRAW_POINTS = 1
  WIN_POINTS = 3

  attr_reader :name, :team_match_outcomes

  def initialize(name:, team_match_outcomes: TeamMatchOutcomeCollection.new)
    @name = name
    @team_match_outcomes = team_match_outcomes
  end

  def_delegators :team_match_outcomes, :draws, :losses, :matches_played, :points, :wins

  def add_draw
    @team_match_outcomes << TeamMatchOutcome.new(outcome: :draw, points: DRAW_POINTS)
  end

  def add_loss
    @team_match_outcomes << TeamMatchOutcome.new(outcome: :loss)
  end

  def add_win
    @team_match_outcomes << TeamMatchOutcome.new(outcome: :win, points: WIN_POINTS)
  end

  def tally_row_values
    [name, matches_played, wins, draws, losses, points]
  end

  def to_str
    Tournament::TALLY_ROW_FORMAT % tally_row_values
  end

  def +(other_team_stat)
    TeamStat.new(
      name: name,
      team_match_outcomes: team_match_outcomes + other_team_stat.team_match_outcomes,
    )
  end

  def <=>(other_team_stat)
    TeamStatComparator.compare(self, other_team_stat)
  end
end
