require_relative './team_match_outcome'

class TeamStat
  DRAW_POINTS = 1
  WIN_POINTS = 3

  attr_reader :name, :team_match_outcomes

  def initialize(name:, team_match_outcomes: [])
    @name = name
    @team_match_outcomes = team_match_outcomes
  end

  def add_draw
    @team_match_outcomes << TeamMatchOutcome.new(outcome: :draw, points: DRAW_POINTS)
  end

  def add_loss
    @team_match_outcomes << TeamMatchOutcome.new(outcome: :loss)
  end

  def add_win
    @team_match_outcomes << TeamMatchOutcome.new(outcome: :win, points: WIN_POINTS)
  end

  def draws
    team_match_outcomes.count &:draw?
  end

  def losses
    team_match_outcomes.count &:loss?
  end

  def matches_played
    team_match_outcomes.count
  end

  def points
    team_match_outcomes.sum &:points
  end

  def tally_row_values
    [name, matches_played, wins, draws, losses, points]
  end

  def to_str
    Tournament::TALLY_ROW_FORMAT % tally_row_values
  end

  def wins
    team_match_outcomes.count &:win?
  end

  def +(other_team_stat)
    TeamStat.new(
      name: name,
      team_match_outcomes: team_match_outcomes + other_team_stat.team_match_outcomes,
    )
  end

  def <=>(other_team_stat)
    cmp = other_team_stat.points <=> self.points
    cmp == 0 ? self.name <=> other_team_stat.name : cmp
  end
end
