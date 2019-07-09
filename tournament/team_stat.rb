require_relative './team_match_outcome'

# An individual team tournament statistic set
class TeamStat
  WIN_POINTS = 3
  DRAW_POINTS = 1

  attr_reader :name, :team_match_outcomes

  def initialize(name:, team_match_outcomes: [])
    @name = name
    @team_match_outcomes = team_match_outcomes
  end

  def draws
    team_match_outcomes.count &:draw?
  end

  def field_values
    [name, matches_played, wins, draws, losses, points]
  end

  def losses
    team_match_outcomes.count &:loss?
  end

  def matches_played
    team_match_outcomes.count
  end

  def add_draw
    @team_match_outcomes << TeamMatchOutcome.new(:draw, DRAW_POINTS)
  end

  def add_loss
    @team_match_outcomes << TeamMatchOutcome.new(:loss)
  end

  def add_win
    @team_match_outcomes << TeamMatchOutcome.new(:win, WIN_POINTS)
  end

  def points
    team_match_outcomes.sum &:points
  end

  def wins
    team_match_outcomes.count &:win?
  end

  def to_str
    Tournament::TALLY_ROW_FORMAT % field_values
  end

  def +(other_stat)
    TeamStat.new(
      name: name,
      team_match_outcomes: team_match_outcomes + other_stat.team_match_outcomes
    )
  end

  def <=>(other_stat)
    comparison = other_stat.points <=> points
    comparison == 0 ? name <=> other_stat.name : comparison
  end
end
